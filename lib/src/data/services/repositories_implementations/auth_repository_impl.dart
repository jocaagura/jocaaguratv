import '../../../domain/models/user_model.dart';
import '../../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserModel?> getUserData() {
    return Future<UserModel?>.value(
      null,
      //UserModel(),
    );
  }

  @override
  Future<bool> get hasActiveSesion => Future<bool>.value(true);
}
