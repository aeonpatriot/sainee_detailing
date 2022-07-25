import 'package:flutter/Material.dart';

class ProfileViewModel extends ChangeNotifier {
  final Map<String, EditProfile> editList = {
    'name': EditProfile(
        appbarTitle: 'Edit Name',
        instructions: 'Name not more than 100 characters'),
    'email': EditProfile(appbarTitle: 'Edit Email', instructions: ''),
    'phone': EditProfile(appbarTitle: 'Edit Phone Number', instructions: ''),
  };

  String? _phoneNumber;
  bool _isPhoneNumberValid = false;

  String? get phoneNumber => _phoneNumber;
  set phoneNumber(value) => _phoneNumber = value;

  bool get isPhoneNumberValid => _isPhoneNumberValid;
  setIsPhoneNumberValid(value) {
    _isPhoneNumberValid = value;
    notifyListeners();
  }
}

class EditProfile {
  EditProfile({appbarTitle, instructions})
      : _appBarTitle = appbarTitle,
        _instructions = instructions;

  final String _appBarTitle;
  final String _instructions;

  String get appBarTitle => _appBarTitle;
  String get instruction => _instructions;
}
