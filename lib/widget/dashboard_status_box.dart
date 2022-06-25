import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';

class DashboardStatusBox extends StatelessWidget {
  const DashboardStatusBox({
    Key? key,
    required this.color,
    required this.statusText,
    required this.statusValue,
    bool? isYellow,
  })  : isYellow = isYellow ?? false,
        super(key: key);

  final MaterialColor color;
  final String statusText;
  final String statusValue;
  final bool isYellow;

  @override
  Widget build(BuildContext context) {
    final TextTheme statusTextStyle = Theme.of(context).textTheme;

    return Expanded(
        child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
        gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: isYellow
                ? [Colors.yellow[600]!, Colors.yellow[600]!]
                : [color, color[600]!]),
      ),
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: Text(
                statusText,
                style: statusTextStyle.headline6
                    ?.copyWith(color: kColorWhite, fontSize: 16),
              )),
          SizedBox(
            width: double.infinity,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                statusValue.toString(),
                style: statusTextStyle.headline5
                    ?.copyWith(color: kColorWhite, fontSize: 30),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
