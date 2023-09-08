import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/models/user_model.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../routes/routes.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String _userName = '';
  String _password = '';
  bool _isValid = false;
  bool _validating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            child: AbsorbPointer(
              absorbing: _validating,
              child: Column(
                children: <Widget>[
                  Text('Nombre: $_userName'),
                  Text('Password: ${_password.replaceAll(RegExp(r'.'), '*')}'),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      label: Text('Nombre'),
                      hintText: 'Pepito',
                    ),
                    onChanged: (String val) {
                      setState(() {
                        _userName = val.trim().toLowerCase();
                      });
                    },
                    validator: (String? text) {
                      if (text != null) {
                        if (_userName.isEmpty) {
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
                    onChanged: (String val) {
                      setState(() {
                        _password = val.replaceAll(' ', '');
                      });
                    },
                    validator: (String? text) {
                      if (text != null) {
                        if (_password.length < 4) {
                          return 'Password invalido';
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Builder(
                    builder: (BuildContext context) {
                      if (_validating) {
                        return const CircularProgressIndicator();
                      }

                      return MaterialButton(
                        onPressed: () {
                          _isValid = Form.of(context).validate();
                          if (_isValid) {
                            submit(context).then((void value) {
                              setState(() {});
                            });
                          }
                        },
                        color: Theme.of(context).colorScheme.primary,
                        child: const Text('Sign in'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submit(BuildContext context) async {
    setState(() {
      _validating = true;
    });
    final Either<SignInFailure, UserModel> result =
        await Provider.of<AuthRepository>(context, listen: false)
            .signIn(_userName, _password);
    if (!mounted) {
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

        _validating = false;
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
