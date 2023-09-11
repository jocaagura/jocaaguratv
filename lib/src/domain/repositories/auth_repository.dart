import '../either.dart';
import '../enums.dart';
import '../models/user/user_model.dart';

abstract class AuthRepository {
  Future<bool> get hasActiveSesion;

  Future<Either<SignInFailure, UserModel>> signIn(
    String userName,
    String password,
  );
  Future<void> signOut();
}
