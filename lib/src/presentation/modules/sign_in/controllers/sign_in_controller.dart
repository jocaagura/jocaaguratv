import '../../../../domain/either.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/models/user/user_model.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../global/controllers/favorites/favorites_controller.dart';
import '../../../global/controllers/session_controller.dart';
import '../../../global/state_notifier.dart';
import 'state/sign_in_state.dart';

class SignInController extends StateNotifier<SignInState> {
  SignInController(
    super.state, {
    required this.authRepository,
    required this.sessionController,
    required this.favoritesController,
  });

  final SessionController sessionController;
  final FavoritesController favoritesController;

  final AuthRepository authRepository;
  void onUserNameChanged(String text) {
    onlyUpdate(
      state.copyWith(
        username: text.trim().toLowerCase(),
      ),
    );
  }

  void onUserPasswordChanged(String text) {
    onlyUpdate(
      state.copyWith(
        password: text.replaceAll(' ', ''),
      ),
    );
  }

  Future<Either<SignInFailure, UserModel>> submit() async {
    state = state.copyWith(
      validating: true,
    );
    final Either<SignInFailure, UserModel> result = await authRepository.signIn(
      state.username,
      state.password,
    );
    result.when(
      (_) => state = state.copyWith(validating: false),
      (UserModel user) {
        sessionController.user = user;
        favoritesController.init();
      },
    );

    return result;
  }

  void validate() {}
}
