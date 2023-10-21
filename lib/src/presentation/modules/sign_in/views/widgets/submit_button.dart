import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/either.dart';
import '../../../../../domain/enums.dart';
import '../../../../../domain/models/user/user_model.dart';
import '../../../../../generated/translations.g.dart';
import '../../../../routes/routes.dart';
import '../../controllers/sign_in_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController signInController = context.watch();
    return ChangeNotifierProvider<SignInController>(
      create: (_) => signInController,
      child: signInController.state.validating
          ? const CircularProgressIndicator()
          : MaterialButton(
              onPressed: () {
                final bool isValid = Form.of(context).validate();
                if (isValid) {
                  submit(context);
                }
              },
              color: Theme.of(context).colorScheme.primary,
              child: Text(texts.signIn.buttons),
            ),
    );
  }

  Future<void> submit(BuildContext context) async {
    final SignInController signInController = context.read();

    final Either<SignInFailure, UserModel> result =
        await signInController.submit();

    if (signInController.mount == false) {
      return;
    }
    result.when(
      (SignInFailure failure) {
        final String error = <SignInFailure, String>{
              SignInFailure.notFound: texts.signIn.errors.submit.notFound,
              SignInFailure.unauthorized:
                  texts.signIn.errors.submit.unauthorized,
              SignInFailure.unknow: texts.signIn.errors.submit.unknow,
              SignInFailure.network: texts.signIn.errors.submit.networkError,
              SignInFailure.emailNotVerified:
                  texts.signIn.errors.submit.emailNotVerified,
            }[failure] ??
            'Absolutely unknow';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
          ),
        );
      },
      (_) => Navigator.of(context).pushReplacementNamed(Routes.home),
    );
  }
}
