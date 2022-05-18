import 'package:flutter/material.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/user.dart';
import 'package:sainee_detailing/services/user_service.dart';
import 'package:sainee_detailing/widget/snackbar.dart';

class LoginViewModel with ChangeNotifier {
  String? _email;
  String? _password;
  bool _hidePassword = true;
  bool _isGenderSame = true;
  bool _isProfileSame = true;
  late User _userDetails;
  late User _userDetailsCopy;

  final userService = service<UserService>();

  User get userDetails => _userDetails;
  User get userDetailsCopy => _userDetailsCopy;
  get email => _email;
  set email(value) => _email = value;
  get password => _password;
  set password(value) => _password = value;
  get hidePassword => _hidePassword;
  setHidePassword() {
    _hidePassword = !_hidePassword;
    notifyListeners();
  }

  get isGenderSame => _isGenderSame;
  set isGenderSame(value) => _isGenderSame = value;
  setIsGenderSame(value) {
    _isGenderSame = value;
    notifyListeners();
  }

  get isProfileSame => _isProfileSame;
  set isProfileSame(value) => _isProfileSame = value;
  setIsProfileSame(value) {
    _isProfileSame = value;
    notifyListeners();
  }

  onLoginPressed(BuildContext context) async {
    final User user = User(
      email: email,
      password: password,
    );

    final _user = await userService.login(user);

    print(_user);

    if (_user == null) {
      print('login failed');
    } else {
      _userDetails = _user;
      _userDetailsCopy = User.copy(_userDetails);
      Navigator.pushNamedAndRemoveUntil(
          context, '/main', ModalRoute.withName('/login'));
    }
  }

  onProfileSave(BuildContext context) async {
    final _user = await userService.updateProfileDetails(userDetailsCopy);

    print(_user?.gender);

    if (_user == null) {
      print('update failed');
    } else {
      _userDetails = _user;
      _userDetailsCopy = User.copy(_userDetails);
      Navigator.pop(context);
      CustomSnackBar.show(
          context: context, message: 'Profile Updated Successfully');
      print('update success');
    }
  }

  onEditProfileScreenSave(BuildContext context) async {
    final String oldGender = userDetailsCopy.gender;
    userDetailsCopy.gender = userDetails.gender;

    final _user = await userService.updateProfileDetails(userDetailsCopy);

    if (_user == null) {
      print('update failed');
    } else {
      _userDetails = _user;
      _userDetailsCopy = User.copy(_userDetails);
      _userDetailsCopy.gender = oldGender;
      Navigator.pop(context);
      CustomSnackBar.show(
          context: context, message: 'Profile Updated Successfully');
      print('update success');
    }
  }

  onEditProfileDiscard(BuildContext context) {
    final String oldGender = userDetailsCopy.gender;
    _userDetailsCopy = User.copy(_userDetails);
    _userDetailsCopy.gender = oldGender;
  }

  onProfileDiscard(BuildContext context) {
    _userDetailsCopy = User.copy(_userDetails);
  }

  void onGoBack() {
    notifyListeners();
  }

  void checkProfile(String editType) {
    if (editType == 'name') {
      if (userDetailsCopy.name == userDetails.name) {
        setIsProfileSame(true);
      } else {
        setIsProfileSame(false);
      }
    } else if (editType == 'email') {
      if (userDetailsCopy.email == userDetails.email) {
        setIsProfileSame(true);
      } else {
        setIsProfileSame(false);
      }
    } else if (editType == 'phone') {
      if (userDetailsCopy.phoneNumber == userDetails.phoneNumber) {
        setIsProfileSame(true);
      } else {
        setIsProfileSame(false);
      }
    }
  }

  void checkGender() {
    if (userDetailsCopy.gender == userDetails.gender) {
      setIsGenderSame(true);
    } else {
      setIsGenderSame(false);
    }
  }
}
