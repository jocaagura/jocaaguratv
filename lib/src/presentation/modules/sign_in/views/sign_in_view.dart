import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/translations.g.dart';
import '../controllers/sign_in_controller.dart';
import '../controllers/state/sign_in_state.dart';
import 'widgets/submit_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final String username = Translations.of(context).signIn.username;
    final String password = Translations.of(context).signIn.password;

    return ChangeNotifierProvider<SignInController>(
      create: (_) => SignInController(
        const SignInState(),
        authRepository: context.read(),
        sessionController: context.read(),
        favoritesController: context.read(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              child: Builder(
                builder: (BuildContext context) {
                  final SignInController signInController =
                      Provider.of(context, listen: true);
                  return AbsorbPointer(
                    absorbing: signInController.state.validating,
                    child: Column(
                      children: <Widget>[
                        Text('$username: ${signInController.state.username}'),
                        Text(
                          '$password: ${signInController.state.password.replaceAll(
                            RegExp(r'.'),
                            '*',
                          )}',
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            label: Text(username),
                            hintText: texts.signIn.hintTexts.usernamehint,
                          ),
                          onChanged: signInController.onUserNameChanged,
                          validator: (String? text) {
                            if (text != null) {
                              if (signInController.state.username.isEmpty) {
                                return texts.signIn.errors.username;
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            label: Text(password),
                            hintText: '******',
                          ),
                          obscureText: true,
                          onChanged: signInController.onUserPasswordChanged,
                          validator: (String? text) {
                            if (text != null) {
                              if (signInController.state.password.length < 4) {
                                return texts.signIn.errors.password;
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const SubmitButton(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
