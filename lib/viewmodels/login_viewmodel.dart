import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/user.dart';
import 'package:sainee_detailing/services/user_service.dart';
import 'package:sainee_detailing/widget/custom_snackbar.dart';

class LoginViewModel with ChangeNotifier {
  String? _email;
  String? _password;
  bool _hidePassword = true;
  bool _isGenderSame = true;
  bool _isProfileSame = true;
  bool _isLoginLoading = false;
  late User _userDetails;
  late User _userDetailsCopy;

  final userService = service<UserService>();

  User get userDetails => _userDetails;
  User get userDetailsCopy => _userDetailsCopy;
  get email => _email;
  set email(value) => _email = value;
  get password => _password;
  set password(value) => _password = value;

  get isLoginLoading => _isLoginLoading;
  setIsLoginLoading(value) {
    _isLoginLoading = value;
    notifyListeners();
  }

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

  void resetHidePassword() {
    _hidePassword = true;
    email = null;
    password = null;
  }

  onLoginPressed(
      BuildContext context, void Function() setFutureDashboardData) async {
    final User user = User(
      email: email,
      password: password,
    );

    final _user = await userService.login(user);

    if (_user == null) {
      setIsLoginLoading(false);
      FailedSnackBar.show(
          context: context,
          title: 'Oh Snap!',
          message: 'Invalid login info. Please check your email or password');
    } else {
      _userDetails = _user;
      _userDetailsCopy = User.copy(_userDetails);
      print(_userDetails.type);
      if (_userDetails.type == 'customer') {
        Navigator.pushNamedAndRemoveUntil(
            context, '/main', ModalRoute.withName('/login'));
      } else {
        setFutureDashboardData();
        Navigator.pushNamedAndRemoveUntil(
            context, '/dashboard', ModalRoute.withName('/login'));
      }
      resetHidePassword();
      setIsLoginLoading(false);
    }
  }

  void onProfileSave(
      {required BuildContext context,
      XFile? profileTempFile,
      XFile? headerTempFile,
      required String userId,
      required VoidCallback clearCache}) async {
    List<Future<dynamic>> requestList = [];
    int nullCount = 0;

    if (!isGenderSame) {
      requestList.add(userService.updateProfileDetails(userDetailsCopy));
    }
    if (headerTempFile != null) {
      requestList.add(userService.updateImage(
          userId: userId, imageFile: headerTempFile, imageType: 'headerImage'));
    }
    if (profileTempFile != null) {
      requestList.add(userService.updateImage(
          userId: userId,
          imageFile: profileTempFile,
          imageType: 'profileImage'));
    }

    final List jsonResults = await Future.wait(requestList);
    if (requestList.length == 3) {
      for (var result in jsonResults) {
        if (result != null) {
          if ((result.headerImagePath != userDetails.headerImagePath) &&
              (result.profileImagePath != userDetails.profileImagePath)) {
            setUserDetailsAfterUpdateImage(result);
          }
        }
      }
    } else {
      for (var result in jsonResults) {
        if (result != null) {
          setUserDetailsAfterUpdateImage(result);
        }
      }
    }

    for (var result in jsonResults) {
      if (result == null) {
        nullCount++;
      }
    }

    if (nullCount == jsonResults.length) {
      clearCache();
      requestList = [];
      FailedSnackBar.show(
          context: context,
          title: 'On Snap!',
          message:
              'There is some problem updating your profile. If this error persists please call our customer service');
    } else {
      clearCache();
      SuccessSnackBar.show(
          context: context, message: 'Profile have been updated successfully');
      Navigator.of(context).pop();
      requestList = [];
    }
  }

  onEditProfileScreenSave(BuildContext context) async {
    final String oldGender = userDetailsCopy.gender;
    userDetailsCopy.gender = userDetails.gender;

    final _user = await userService.updateProfileDetails(userDetailsCopy);

    if (_user == null) {
    } else {
      _userDetails = _user;
      _userDetailsCopy = User.copy(_userDetails);
      _userDetailsCopy.gender = oldGender;
      Navigator.pop(context);
      SuccessSnackBar.show(
          context: context, message: 'Profile Have Been Updated Successfully');
    }
  }

  onEditProfileDiscard() {
    final String oldGender = userDetailsCopy.gender;
    _userDetailsCopy = User.copy(_userDetails);
    _userDetailsCopy.gender = oldGender;
  }

  onProfileDiscard() {
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

  void setUserDetailsAfterUpdateImage(User newUserDetails) {
    _userDetails = newUserDetails;
    _userDetailsCopy = User.copy(_userDetails);
    notifyListeners();
  }
}
