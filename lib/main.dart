import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
    Provider<ConnectivityRepository>(
      create: (BuildContext context) {
        return ConnectivityRepositoryImpl(
          Connectivity(),
          InternetChecker(),
        );
      },
      child: Provider<AuthRepository>(
        create: (BuildContext context) => AuthRepositoryImpl(
          const FlutterSecureStorage(),
          AuthApi(
            Http(
              kBaseUrl,
              http.Client(),
            ),
          ),
        ),
        child: const MyApp(),
      ),
    ),
  );
}
