import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String _key = 'jocaaguratvsesionid';

class SessionService {
  const SessionService(this._securedStorage);

  final FlutterSecureStorage _securedStorage;

  Future<String?> get sessionId async {
    return _securedStorage.read(key: _key);
  }

  Future<void> saveSessionId(String sessionId) async {
    return _securedStorage.write(
      key: _key,
      value: sessionId,
    );
  }

  Future<void> deleteSesion() async {
    return _securedStorage.delete(key: _key);
  }
}
