import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/models/user/user_model.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../local/session_service.dart';
import '../remote/account_api.dart';
import '../remote/auth_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(
    this._sessionService,
    this._authApi,
    this._accountApi,
  );
  final SessionService _sessionService;
  final AuthApi _authApi;
  final AccountApi _accountApi;

  @override
  Future<bool> get hasActiveSesion async {
    final String? sesionId = await _sessionService.sessionId;
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
      }, (String sesionToken) async {
        await _sessionService.saveSessionId(sesionToken);
        final UserModel? userModel = await _accountApi.getAccount(sesionToken);
        if (userModel == null) {
          return const Left<SignInFailure, UserModel>(SignInFailure.unknow);
        } else {
          return Right<SignInFailure, UserModel>(userModel);
        }
      });
    });
  }

  @override
  Future<void> signOut() async {
    return _sessionService.deleteSesion();
  }
}
