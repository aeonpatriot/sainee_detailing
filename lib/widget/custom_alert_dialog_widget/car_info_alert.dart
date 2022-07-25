import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';

class CarInfoAlertDialog {
  static showAlertDialog({required BuildContext context}) {
    final TextStyle? textStyle = Theme.of(context).textTheme.bodyText1;

    showDialog(
        useRootNavigator: true,
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog(
              content: SizedBox(
                height: 420,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/car category edited crop.png'),
                    const SizedBox(height: 20),
                    Text(
                      'Small: A-Segment, B-Segment',
                      style: textStyle,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Medium: C-Segment, D-Segment, E-Segment, F-Segment',
                      style: textStyle,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Large: Pickup Truck or Larger than SUV',
                      style: textStyle,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'SUV: Compact SUV, SUV',
                      style: textStyle,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'MPV: Compact MPV, MPV',
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text(
                    'Close',
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
