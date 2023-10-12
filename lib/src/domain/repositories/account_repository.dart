import '../either.dart';
import '../failures/http_requets/http_request_failure.dart';
import '../models/media/media_model.dart';
import '../models/user/user_model.dart';

abstract class AccountRepository {
  const AccountRepository();
  Future<UserModel?> getUserData();

  Future<Either<HttpRequestFailure, Map<int, MediaModel>>> getFavorites(
    MediaType mediaType,
  );
}
