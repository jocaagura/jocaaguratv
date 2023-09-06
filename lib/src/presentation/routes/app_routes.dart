import 'package:flutter/material.dart';

import '../modules/splash/views/splash_view.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return <String, WidgetBuilder>{
    Routes.splash: (BuildContext context) => const SplashView(),
  };
}
