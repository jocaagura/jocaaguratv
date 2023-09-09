import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/sign_in_controller.dart';
import '../controllers/sign_in_state.dart';
import 'widgets/submit_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInController>(
      create: (_) => SignInController(
        const SignInState(),
        authRepository: context.read(),
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
                  print('🤦‍♀️ Aqui si ${signInController.state.validating}');
                  return AbsorbPointer(
                    absorbing: signInController.state.validating,
                    child: Column(
                      children: <Widget>[
                        Text('Nombre: ${signInController.state.username}'),
                        Text(
                          'Password: ${signInController.state.password.replaceAll(
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
                              if (signInController.state.username.isEmpty) {
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
                              if (signInController.state.password.length < 4) {
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
