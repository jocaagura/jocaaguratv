import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

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
import 'src/data/services/repositories_implementations/preference_repository_impl.dart';
import 'src/data/services/repositories_implementations/trending_repository_impl.dart';
import 'src/domain/repositories/account_repository.dart';
import 'src/domain/repositories/auth_repository.dart';
import 'src/domain/repositories/connectivity_repository.dart';
import 'src/domain/repositories/movies_repository.dart';
import 'src/domain/repositories/preference_repository.dart';
import 'src/domain/repositories/trending_repository.dart';
import 'src/generated/translations.g.dart';
import 'src/my_app.dart';
import 'src/presentation/global/controllers/favorites/favorites_controller.dart';
import 'src/presentation/global/controllers/favorites/state/favorites_state.dart';
import 'src/presentation/global/controllers/session_controller.dart';
import 'src/presentation/global/controllers/theme_controller.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  const SessionService sessionService = SessionService(FlutterSecureStorage());
  final Http httpImpl = Http(
    kBaseUrl,
    http.Client(),
  );
  final AccountApi accountApi = AccountApi(
    httpImpl,
    sessionService,
  );

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
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
        Provider<PreferenceRepository>(
          create: (BuildContext context) =>
              PreferenceRepositoryImpl(sharedPreferences),
        ),
        ChangeNotifierProvider<SessionController>(
          create: (BuildContext context) => SessionController(context.read()),
        ),
        ChangeNotifierProvider<FavoritesController>(
          create: (BuildContext context) => FavoritesController(
            const FavoritesState.loading(),
            accountRepository: context.read(),
          ),
        ),
        ChangeNotifierProvider<ThemeController>(
          create: (BuildContext context) {
            final PreferenceRepository preferenceRepositiry =
                context.read<PreferenceRepository>();
            return ThemeController(
              preferenceRepositiry.darkMode,
              preferenceRepositiry,
            );
          },
        ),
      ],
      child: TranslationProvider(
        child: const MyApp(),
      ),
    ),
  );
}
