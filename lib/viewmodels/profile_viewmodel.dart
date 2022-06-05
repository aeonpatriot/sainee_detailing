import 'package:flutter/Material.dart';

class ProfileViewModel extends ChangeNotifier {
  //TODO need to check the profile details for update
  final Map<String, EditProfile> editList = {
    'name': EditProfile(
        appbarTitle: 'Edit Name',
        instructions: 'Name not more than 100 characters'),
    'email': EditProfile(appbarTitle: 'Edit Email', instructions: ''),
    'phone': EditProfile(appbarTitle: 'Edit Phone Number', instructions: ''),
  };
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
