import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../../domain/models/user_model.dart';
import '../../../../domain/repositories/auth_repository.dart';
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
    final Injector injector = Injector.of(context);
    final bool hasInternet = await injector.connectivityRepository.hasInternet;
    if (hasInternet) {
      final AuthRepository auth = injector.authRepository;
      if (await auth.hasActiveSesion && mounted) {
        final UserModel? userModel = await auth.getUserData();
        if (userModel == null) {
          _goTo(Routes.signIn);
        } else {
          _goTo(Routes.home);
        }
      } else if (mounted) {
        _goTo(Routes.signIn);
      }
    } else {
      _goTo(Routes.offline);
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
