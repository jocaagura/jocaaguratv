abstract class ConnectivityRepository {
  bool get hasInternet;
  Stream<bool> get onInternetChanged;
}
