import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controllers/session_controller.dart';
import '../../../routes/routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final SessionController sessionController = context.watch();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(sessionController.state?.id.toString() ?? ''),
          Text(sessionController.state?.avatarPath.toString() ?? ''),
          if (sessionController.state?.avatarPath != null &&
              sessionController.state?.avatarPath != 'error')
            Image.network(
              'https://image.tmdb.org/t/p/w500${sessionController.state?.avatarPath}',
            ),
          Text(sessionController.state?.username ?? ''),
          MaterialButton(
            color: Theme.of(context).colorScheme.error,
            child: const Text('Cerrar sesion'),
            onPressed: () {
              sessionController.signOut();
              Navigator.of(context).pushReplacementNamed(
                Routes.splash,
              );
            },
          ),
        ],
      ),
    );
  }
}
