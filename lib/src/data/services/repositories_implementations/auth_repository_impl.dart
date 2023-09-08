import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/models/user_model.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../remote/auth_api.dart';

const String _key = 'jocaaguratvsesionid';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(
    this._securedStorage,
    this._authApi,
  );
  final FlutterSecureStorage _securedStorage;
  final AuthApi _authApi;
  @override
  Future<UserModel?> getUserData() async {
    final String? sesionId = await _securedStorage.read(key: _key);
    if (sesionId != null) {
      // TODO(jocaagura): Generar codigo para la recuperacion del usuario

      return UserModel();
    }
    return Future<UserModel?>.value();
  }

  @override
  Future<bool> get hasActiveSesion async {
    final String? sesionId = await _securedStorage.read(key: _key);
    if (sesionId != null) {
      return true;
    }
    return false;
  }

  @override
  Future<Either<SignInFailure, UserModel>> signIn(
    String userName,
    String password,
  ) async {
    String requestToken = '';
    final Either<SignInFailure, String> res =
        await _authApi.createRequestToken();
    res.when((SignInFailure p0) {
      return Left<SignInFailure, String>(p0);
    }, (String p0) {
      requestToken = p0;
    });

    if (requestToken.isEmpty) {
      return const Left<SignInFailure, UserModel>(SignInFailure.network);
    }
    final Either<SignInFailure, String> loginResult =
        await _authApi.createSessionWithLogin(
      username: userName,
      password: password,
      requestToken: requestToken,
    );

    return loginResult.when((SignInFailure signInFailure) {
      return Left<SignInFailure, UserModel>(signInFailure);
    }, (String newRequestToken) async {
      final Either<SignInFailure, String> sesionResult =
          await _authApi.createSession(newRequestToken);
      return sesionResult.when((SignInFailure signInFailure) {
        return Left<SignInFailure, UserModel>(signInFailure);
      }, (String sesionToken) {
        _securedStorage.write(
          key: _key,
          value: sesionToken,
        );
        return Right<SignInFailure, UserModel>(
          // TODO(jocaagura): Completar el modelo usuario
          UserModel(),
        );
      });
    });
  }

  @override
  Future<void> signOut() async {
    await _securedStorage.delete(key: _key);
  }
}
