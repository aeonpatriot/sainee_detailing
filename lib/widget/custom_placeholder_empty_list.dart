import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';

class CustomPlaceholderEmptyList extends StatelessWidget {
  const CustomPlaceholderEmptyList({
    Key? key,
    required this.firstText,
    required this.secondText,
    required this.thirdText,
  }) : super(key: key);

  final String firstText;
  final String secondText;
  final String thirdText;

  @override
  Widget build(BuildContext context) {
    final TextStyle? textstyle = Theme.of(context)
        .textTheme
        .headline6
        ?.copyWith(color: kSecondaryColorDark);

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              firstText,
              style: textstyle,
            ),
            Text(
              secondText,
              style: textstyle,
            ),
            Text(
              thirdText,
              style: textstyle,
            ),
          ],
        ),
      ),
    );
  }
}
