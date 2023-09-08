import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repositories/auth_repository.dart';
import '../../../routes/routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Home'),
            MaterialButton(
              color: Theme.of(context).colorScheme.error,
              child: const Text('Cerrar sesion'),
              onPressed: () {
                Provider.of<AuthRepository>(context, listen: false).signOut();
                Navigator.of(context).pushReplacementNamed(
                  Routes.splash,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
