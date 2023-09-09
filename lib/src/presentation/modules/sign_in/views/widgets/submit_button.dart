import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/either.dart';
import '../../../../../domain/enums.dart';
import '../../../../../domain/models/user_model.dart';
import '../../../../../domain/repositories/auth_repository.dart';
import '../../../../routes/routes.dart';
import '../../controllers/sign_in_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController signInController = context.watch();
    return ChangeNotifierProvider<SignInController>(
      create: (_) => signInController,
      child: signInController.state.validating == true
          ? const CircularProgressIndicator()
          : MaterialButton(
              onPressed: () {
                final bool isValid = Form.of(context).validate();
                if (isValid) {
                  submit(context);
                }
              },
              color: Theme.of(context).colorScheme.primary,
              child: const Text('Sign in'),
            ),
    );
  }

  Future<void> submit(BuildContext context) async {
    final SignInController signInController = context.read();

    signInController.onFetchingChanged(true);

    final Either<SignInFailure, UserModel> result =
        await context.read<AuthRepository>().signIn(
              signInController.state.username,
              signInController.state.password,
            );
    if (signInController.mount == false) {
      return;
    }
    result.when(
      (SignInFailure failure) {
        final String error = <SignInFailure, String>{
              SignInFailure.notFound: 'Not found',
              SignInFailure.unauthorized: 'Unauthorized',
              SignInFailure.unknow: 'Unknow',
              SignInFailure.network: 'Network error',
            }[failure] ??
            'Absolutely unknow';

        signInController.onFetchingChanged(false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
          ),
        );
      },
      (UserModel p0) {
        Navigator.of(context).pushReplacementNamed(Routes.home);
      },
    );
  }
}
