import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../domain/repositories/connectivity_repository.dart';
import '../remote/internet_checker.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  ConnectivityRepositoryImpl(
    this._connectivity,
    this._internetChecker,
  ) {
    _initializated();
  }

  final Connectivity _connectivity;
  final InternetChecker _internetChecker;
  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  bool _hasInternet = false;

  @override
  bool get hasInternet => _hasInternet;

  @override
  Stream<bool> get onInternetChanged => _controller.stream;
  StreamSubscription<bool>? streamSubscription;
  Future<void> _initializated() async {
    Future<bool> hasInternet(ConnectivityResult result) async {
      return result != ConnectivityResult.none &&
          await _internetChecker.hasInternet();
    }

    _hasInternet = await hasInternet(await _connectivity.checkConnectivity());
    _connectivity.onConnectivityChanged
        .listen((ConnectivityResult event) async {
      if (_controller.hasListener && !_controller.isClosed) {
        streamSubscription?.cancel();
        streamSubscription =
            hasInternet(event).asStream().listen((bool isConnected) {
          final bool d = isConnected;
          _hasInternet = d;
          _controller.add(
            d,
          );
        });
      }
    });
  }
}
