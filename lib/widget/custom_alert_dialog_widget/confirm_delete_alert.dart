import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';

class ConfirmDeleteAlert {
  static showAlertDialog(
      {required BuildContext context, required VoidCallback onDeletePressed}) {
    showDialog(
        useRootNavigator: true,
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog(
              content: Text(
                'Delete Address?',
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
                    'Delete',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: kPrimaryColorDarker),
                  ),
                  onPressed: onDeletePressed,
                )
              ],
            ));
  }
}
