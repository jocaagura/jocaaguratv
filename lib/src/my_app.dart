import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/global/controllers/theme_controller.dart';
import 'presentation/global/theme.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = context.watch();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        initialRoute: Routes.splash,
        routes: appRoutes,
        theme: getTheme(themeController.isDarkMode),
        onUnknownRoute: (_) => MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => Scaffold(
            body: Center(
              child: Image.asset('assets/error404.png'),
            ),
          ),
        ),
      ),
    );
  }
}
