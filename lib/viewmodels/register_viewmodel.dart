import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  bool _hidePassword = true;
  get hidePasword => _hidePassword;
  setHidePassword() {
    _hidePassword = !_hidePassword;
    notifyListeners();
  }

  bool _hideConfirmPassword = true;
  get hideConfirmPassword => _hideConfirmPassword;
  setHideConfirmPassword() {
    _hideConfirmPassword = !_hideConfirmPassword;
    notifyListeners();
  }

  void resetHidePassword() {
    _hideConfirmPassword = true;
    _hidePassword = true;
  }
}
