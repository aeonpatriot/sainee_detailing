import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';

class CustomPlaceholderEmptyList extends StatelessWidget {
  const CustomPlaceholderEmptyList({
    Key? key,
    this.firstText,
    this.secondText,
    this.thirdText,
    this.iconUrl,
  }) : super(key: key);

  final String? firstText;
  final String? secondText;
  final String? thirdText;
  final String? iconUrl;

  @override
  Widget build(BuildContext context) {
    final TextStyle? textstyle =
        Theme.of(context).textTheme.headline6?.copyWith(color: kColorBlack);

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconUrl != null ? Image.asset(iconUrl!) : Container(),
            firstText != null
                ? Text(
                    firstText!,
                    style: textstyle,
                  )
                : Container(),
            secondText != null
                ? Text(
                    secondText!,
                    style: textstyle,
                  )
                : Container(),
            thirdText != null
                ? Text(
                    thirdText!,
                    style: textstyle,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
