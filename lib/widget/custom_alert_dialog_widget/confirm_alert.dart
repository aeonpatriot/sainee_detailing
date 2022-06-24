import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';

class CustomAlertDialog {
  static showAlertDialog(
      {required BuildContext context,
      required VoidCallback onButtonPressed,
      required String alertText,
      required String buttonText}) {
    showDialog(
        useRootNavigator: true,
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog(
              content: Text(
                alertText,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              actions: [
                TextButton(
                  child: Text(
                    'No',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text(
                    buttonText,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: kPrimaryColorDarker),
                  ),
                  onPressed: onButtonPressed,
                )
              ],
            ));
  }
}
