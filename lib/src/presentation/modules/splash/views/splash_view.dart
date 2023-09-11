import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/user/user_model.dart';
import '../../../../domain/repositories/account_repository.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../../domain/repositories/connectivity_repository.dart';
import '../../../global/controllers/session_controller.dart';
import '../../../routes/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    final String routeName = await () async {
      final ConnectivityRepository connectivityRepository = context.read();
      final AuthRepository auth = context.read();
      final AccountRepository accountRepository = context.read();
      final bool hasInternet = await connectivityRepository.hasInternet;
      final SessionController sessionController = context.read();

      if (!hasInternet) {
        return Routes.offline;
      }
      final bool isSignedIn = await auth.hasActiveSesion;
      if (!isSignedIn) {
        return Routes.signIn;
      }
      final UserModel? userModel = await accountRepository.getUserData();
      if (userModel != null) {
        sessionController.state = userModel;
        return Routes.home;
      }
      return Routes.signIn;
    }();
    if (mounted) {
      _goTo(routeName);
    }
  }

  Future<void> _goTo(String routeName) async {
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 80.0,
          height: 80.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
