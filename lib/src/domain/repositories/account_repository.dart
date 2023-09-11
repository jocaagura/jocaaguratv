import '../models/user/user_model.dart';

abstract class AccountRepository {
  const AccountRepository();
  Future<UserModel?> getUserData();
}
