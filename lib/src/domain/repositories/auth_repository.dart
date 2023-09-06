import '../models/user_model.dart';

abstract class AuthRepository {
  Future<bool> get hasActiveSesion;
  Future<UserModel?> getUserData();
}
