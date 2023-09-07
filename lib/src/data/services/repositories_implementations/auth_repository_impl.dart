import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../domain/models/user_model.dart';
import '../../../domain/repositories/auth_repository.dart';

const String _key = 'jocaaguratvsesionid';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._securedStorage);
  final FlutterSecureStorage _securedStorage;

  @override
  Future<UserModel?> getUserData() {
    return Future<UserModel?>.value(
      null,
      //UserModel(),
    );
  }

  @override
  Future<bool> get hasActiveSesion async {
    final String? sesionId = await _securedStorage.read(key: _key);
    if (sesionId != null) {
      return true;
    }
    return false;
  }
}
