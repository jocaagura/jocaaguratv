import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'src/data/services/http/http.dart';
import 'src/data/services/local/session_service.dart';
import 'src/data/services/remote/account_api.dart';
import 'src/data/services/remote/auth_api.dart';
import 'src/data/services/remote/internet_checker.dart';
import 'src/data/services/remote/movies_api.dart';
import 'src/data/services/remote/trending_api.dart';
import 'src/data/services/repositories_implementations/account_repository_impl.dart';
import 'src/data/services/repositories_implementations/auth_repository_impl.dart';
import 'src/data/services/repositories_implementations/connectivity_repository_imp.dart';
import 'src/data/services/repositories_implementations/movies_repository_impl.dart';
import 'src/data/services/repositories_implementations/trending_repository_impl.dart';
import 'src/domain/repositories/account_repository.dart';
import 'src/domain/repositories/auth_repository.dart';
import 'src/domain/repositories/connectivity_repository.dart';
import 'src/domain/repositories/movies_repository.dart';
import 'src/domain/repositories/trending_repository.dart';
import 'src/my_app.dart';
import 'src/presentation/global/controllers/session_controller.dart';

void main() {
  const SessionService sessionService = SessionService(FlutterSecureStorage());
  final Http httpImpl = Http(
    kBaseUrl,
    http.Client(),
  );
  final AccountApi accountApi = AccountApi(httpImpl);
  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        Provider<AccountRepository>(
          create: (_) => AccountRepositoryImpl(
            accountApi,
            sessionService,
          ),
        ),
        Provider<ConnectivityRepository>(
          create: (_) {
            return ConnectivityRepositoryImpl(
              Connectivity(),
              InternetChecker(),
            );
          },
        ),
        Provider<AuthRepository>(
          create: (_) => AuthRepositoryImpl(
            sessionService,
            AuthApi(
              httpImpl,
            ),
            accountApi,
          ),
        ),
        Provider<TrendingRepository>(
          create: (_) => TrendingRepositoryImpl(
            TrendingApi(httpImpl),
          ),
        ),
        Provider<MoviesRepository>(
          create: (_) => MoviesRepositoryImpl(
            MoviesApi(httpImpl),
          ),
        ),
        ChangeNotifierProvider<SessionController>(
          create: (BuildContext context) => SessionController(context.read()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
