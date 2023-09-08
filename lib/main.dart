import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'src/data/services/http/http.dart';
import 'src/data/services/remote/auth_api.dart';
import 'src/data/services/remote/internet_checker.dart';
import 'src/data/services/repositories_implementations/auth_repository_impl.dart';
import 'src/data/services/repositories_implementations/connectivity_repository_imp.dart';
import 'src/domain/repositories/auth_repository.dart';
import 'src/domain/repositories/connectivity_repository.dart';
import 'src/my_app.dart';

void main() {
  runApp(
    Injector(
      authRepository: AuthRepositoryImpl(
        const FlutterSecureStorage(),
        AuthApi(
          Http(
            kBaseUrl,
            http.Client(),
          ),
        ),
      ),
      connectivityRepository: ConnectivityRepositoryImpl(
        Connectivity(),
        InternetChecker(),
      ),
      child: const MyApp(),
    ),
  );
}

class Injector extends InheritedWidget {
  const Injector({
    required this.connectivityRepository,
    required this.authRepository,
    required super.child,
    super.key,
  });

  final ConnectivityRepository connectivityRepository;
  final AuthRepository authRepository;
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static Injector of(BuildContext context) {
    final Injector? injector =
        context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null, 'Injector could not be found');
    return injector!;
  }
}
