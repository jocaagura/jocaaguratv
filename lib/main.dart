import 'package:flutter/cupertino.dart';

import 'src/data/services/repositories_implementations/auth_repository_impl.dart';
import 'src/data/services/repositories_implementations/connectivity_repository_imp.dart';
import 'src/domain/repositories/auth_repository.dart';
import 'src/domain/repositories/connectivity_repository.dart';
import 'src/my_app.dart';

void main() {
  runApp(
    Injector(
      authRepository: AuthRepositoryImpl(),
      connectivityRepository: ConnectivityRepositoryImpl(),
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
