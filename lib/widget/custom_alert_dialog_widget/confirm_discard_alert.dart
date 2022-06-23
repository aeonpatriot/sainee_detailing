import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';

class ConfirmDiscardAlert {
  static showAlertDialog(
      {required BuildContext context, required VoidCallback onDiscardPressed}) {
    showDialog(
        useRootNavigator: true,
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog(
              content: Text(
                'Discard Changes?',
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
                    'Discard',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: kPrimaryColorDarker),
                  ),
                  onPressed: onDiscardPressed,
                )
              ],
            ));
  }
}
