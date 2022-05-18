import 'package:flutter/Material.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';

class ConfirmDiscardalert {
  static showAlertDialog(
      {required BuildContext context,
      required LoginViewModel loginViewModel,
      required bool isEditScreen}) {
    showDialog(
        useRootNavigator: true,
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog(
              content: const Text('Discard Changes?'),
              actions: [
                TextButton(
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: const Text(
                    'Discard',
                    style: TextStyle(color: kPrimaryColorDarker, fontSize: 16),
                  ),
                  onPressed: () {
                    if (isEditScreen) {
                      loginViewModel.onEditProfileDiscard(context);
                    } else {
                      loginViewModel.onProfileDiscard(context);
                    }
                    Navigator.pop(context);
                    Navigator.pop(context);
                    if (isEditScreen) {
                      loginViewModel.isProfileSame = true;
                    } else {
                      loginViewModel.isGenderSame = true;
                    }
                  },
                )
              ],
            ));
  }
}
