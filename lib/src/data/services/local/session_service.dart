import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String _key = 'jocaaguratvsesionid';
const String _accountId = 'jocaaguratvaccountid';

class SessionService {
  const SessionService(this._securedStorage);

  final FlutterSecureStorage _securedStorage;

  Future<String?> get sessionId => _securedStorage.read(key: _key);

  Future<String?> get accountId => _securedStorage.read(key: _accountId);

  Future<void> saveSessionId(String sessionId) async {
    return _securedStorage.write(
      key: _key,
      value: sessionId,
    );
  }

  Future<void> saveAccountId(String accountId) async {
    return _securedStorage.write(
      key: _accountId,
      value: accountId,
    );
  }

  Future<void> deleteSesion() async {
    _securedStorage.deleteAll();
  }
}
