import '../../../domain/models/user_model.dart';
import '../state_notifier.dart';

class SessionController extends StateNotifier<UserModel?> {
  SessionController() : super(null);
  // void newUser(UserModel userModel) {
  //   state = userModel;
  // }

  void signOut() {
    state = null;
  }
}
