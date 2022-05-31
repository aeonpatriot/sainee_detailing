import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';

class InfoAlert {
  static showAlertDialog({required BuildContext context}) {
    showDialog(
        useRootNavigator: true,
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog(
              content: Text(
                'The default address cannot be un-selected. You can set another address as default address instead.',
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.visible,
              ),
              actions: [
                TextButton(
                  child: Text(
                    'OK',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: kPrimaryColorDarker),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }
}
