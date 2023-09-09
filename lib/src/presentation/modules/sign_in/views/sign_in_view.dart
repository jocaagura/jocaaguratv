import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/sign_in_controller.dart';
import 'widgets/submit_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInController>(
      create: (_) => SignInController(),
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
                    absorbing: signInController.validating,
                    child: Column(
                      children: <Widget>[
                        Text('Nombre: ${signInController.username}'),
                        Text(
                          'Password: ${signInController.password.replaceAll(
                            RegExp(r'.'),
                            '*',
                          )}',
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            label: Text('Nombre'),
                            hintText: 'Pepito',
                          ),
                          onChanged: signInController.onUserNameChanged,
                          validator: (String? text) {
                            if (text != null) {
                              if (signInController.username.isEmpty) {
                                return 'Escriba un nombre de usuario';
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
                          decoration: const InputDecoration(
                            label: Text('Password'),
                            hintText: '******',
                          ),
                          obscureText: true,
                          onChanged: signInController.onUserPasswordChanged,
                          validator: (String? text) {
                            if (text != null) {
                              if (signInController.password.length < 4) {
                                return 'Password invalido';
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
