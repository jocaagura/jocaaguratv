import '../models/user_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserModel> getUserData() {
    return Future<UserModel>.value(
      UserModel(),
    );
  }

  @override
  Future<bool> get hasActiveSesion => Future<bool>.value(true);
}
