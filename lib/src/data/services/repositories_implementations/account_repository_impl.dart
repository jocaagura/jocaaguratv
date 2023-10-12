import '../../../domain/either.dart';
import '../../../domain/failures/http_requets/http_request_failure.dart';
import '../../../domain/models/media/media_model.dart';
import '../../../domain/models/user/user_model.dart';
import '../../../domain/repositories/account_repository.dart';
import '../local/session_service.dart';
import '../remote/account_api.dart';

class AccountRepositoryImpl implements AccountRepository {
  const AccountRepositoryImpl(
    this._accountApi,
    this._sessionService,
  );

  final AccountApi _accountApi;
  final SessionService _sessionService;

  @override
  Future<UserModel?> getUserData() async {
    final String? sessionId = await _sessionService.sessionId;
    if (sessionId != null) {
      final UserModel? user = await _accountApi.getAccount(sessionId);
      if (user != null) {
        _sessionService.saveAccountId(user.id.toString());
      }
      return user;
    }
    return Future<UserModel?>.value();
  }

  @override
  Future<Either<HttpRequestFailure, Map<int, MediaModel>>> getFavorites(
    MediaType mediaType,
  ) {
    return _accountApi.getFavorites(mediaType);
  }
}
