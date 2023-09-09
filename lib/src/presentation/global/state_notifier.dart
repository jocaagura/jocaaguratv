import 'package:flutter/foundation.dart';

abstract class StateNotifier<State> extends ChangeNotifier {
  StateNotifier(this._state) : _oldState = _state;
  State _state;
  State _oldState;

  State get state => _state;
  State get oldState => _oldState;
  bool get mount => _mount;
  bool _mount = true;
  set state(State newState) {
    _update(newState);
  }

  void onlyUpdate(State newState) {
    _update(
      newState,
      notify: false,
    );
  }

  void _update(
    State newState, {
    bool notify = true,
  }) {
    if (_oldState != newState) {
      _oldState = newState;
      _state = newState;
      if (notify) {
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _mount = false;
    super.dispose();
  }
}
