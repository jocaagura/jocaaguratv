import '../../../domain/repositories/connectivity_repository.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  @override
  Future<bool> get hasInternet {
    return Future<bool>.delayed(const Duration(seconds: 2), () {
      return false;
    });
  }
}
