import 'package:flutter/material.dart';

import 'presentation/modules/home/views/home_view.dart';
import 'presentation/modules/movies/views/movie_view.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        initialRoute: Routes.splash,
        routes: appRoutes,
        onUnknownRoute: (_) => MaterialPageRoute<dynamic>(
          builder: (_) => Scaffold(
            body: Center(
              child: Column(
                children: <Widget>[
                  const Expanded(
                    child: SizedBox(),
                  ),
                  AspectRatio(
                    aspectRatio: 9 / 3,
                    child: Image.asset('assets/error404.png'),
                  ),
                  const Text('Error 404'),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        onGenerateRoute: (RouteSettings settings) {
          final Uri uri = Uri.parse(settings.name ?? '/');
          final String path = uri.path;

          try {
            if (path.startsWith('/movie')) {
              final int id = int.tryParse(
                    uri.pathSegments.last,
                  ) ??
                  0;
              if (id == 0) {
                return MaterialPageRoute<dynamic>(
                  builder: (_) => const HomeView(),
                );
              }
              return MaterialPageRoute<dynamic>(
                builder: (_) => MovieView(movieId: id),
                settings: settings,
              );
            }
          } catch (e) {
            return MaterialPageRoute<dynamic>(
              builder: (_) => Scaffold(
                body: Center(
                  child: Text(e.toString()),
                ),
              ),
              settings: settings,
            );
          }
          return null;
        },
      ),
    );
  }
}
