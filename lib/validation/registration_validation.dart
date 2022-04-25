import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/user.dart';
import 'package:sainee_detailing/services/user_service.dart';
import 'package:sainee_detailing/validation/validation_item.dart';

class RegistrationValidation with ChangeNotifier {
  ValidationItem _name = ValidationItem(null, null);
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);
  ValidationItem _confirmPassword = ValidationItem(null, null);

  // final User user = User();
  final UserService userService = service();

  ValidationItem get name => _name;
  ValidationItem get email => _email;
  ValidationItem get password => _password;
  ValidationItem get confirmPassword => _confirmPassword;
  bool get isValid {
    if (name.value != null &&
        email.value != null &&
        password.value != null &&
        password.value == confirmPassword.value) {
      return true;
    } else {
      return false;
    }
  }

  void setName(String value) {
    if (value != null && value.length >= 3) {
      _name = ValidationItem(value, null);
    } else {
      _name = ValidationItem(null, 'Must be at least 3 characters');
    }
    notifyListeners();
  }

  void setEmail(String value) {
    if (value != null && EmailValidator.validate(value)) {
      _email = ValidationItem(value, null);
    } else {
      _email = ValidationItem(null, 'Enter a valid email');
    }
    notifyListeners();
  }

  void setPassword(String value) {
    if (value != null && value.length >= 7) {
      _password = ValidationItem(value, null);
    } else {
      _password = ValidationItem(null, 'Must be at least 7 characters');
    }
    checkPassword();
    // notifyListeners();
  }

  void setConfirmPassword(String value) {
    _confirmPassword = ValidationItem(value, null);
    checkPassword();
  }

  void checkPassword() {
    if (password.value == confirmPassword.value) {
      _confirmPassword = ValidationItem(confirmPassword.value, null);
    } else {
      _confirmPassword = ValidationItem(null, 'The password is not match');
    }
    notifyListeners();
  }

  void submitRegistration() async {
    final User user = User(
        name: name.value,
        email: email.value,
        password: password.value,
        type: 'customer',
        image: 'test');

    print(user.name);
    print(user.email);
    print(user.password);
    print(user.type);
    print(user.image);

    final _user = await userService.createNewUser(user);

    if (_user == null) print('Regiter failed');
    // else
    // Navigator.pushReplacementNamed(context, '/registersuccess');
  }
}
