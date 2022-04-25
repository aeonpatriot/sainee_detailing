import 'package:flutter/material.dart';
import 'package:sainee_detailing/models/user.dart';

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
}
