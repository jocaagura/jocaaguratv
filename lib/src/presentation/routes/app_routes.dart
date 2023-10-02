import 'package:flutter/material.dart';

import '../modules/home/views/home_view.dart';
import '../modules/movies/views/movie_view.dart';
import '../modules/offline/views/offline_view.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/splash/views/splash_view.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return <String, WidgetBuilder>{
    Routes.splash: (BuildContext context) => const SplashView(),
    Routes.signIn: (BuildContext context) => const SignInView(),
    Routes.home: (BuildContext context) => const HomeView(),
    Routes.offline: (BuildContext context) => const OfflineView(),
    Routes.movie: (BuildContext context) => MovieView(
          movieId: ModalRoute.of(context)?.settings.arguments as int? ?? 0,
        ),
  };
}
