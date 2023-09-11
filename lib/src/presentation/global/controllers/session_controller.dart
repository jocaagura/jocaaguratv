import '../../../domain/models/user/user_model.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../state_notifier.dart';

class SessionController extends StateNotifier<UserModel?> {
  SessionController(this._authRepository) : super(null);
  final AuthRepository _authRepository;

  Future<void> signOut() async {
    await _authRepository.signOut();
    state = null;
  }
}
