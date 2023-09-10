import '../../../domain/models/user_model.dart';
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
      return _accountApi.getAccount(sessionId);
    }
    return Future<UserModel?>.value();
  }
}
