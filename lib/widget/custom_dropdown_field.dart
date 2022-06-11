// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';

class CustomDropdownField extends StatelessWidget {
  CustomDropdownField({
    Key? key,
    this.onChanged,
    required this.items,
    required this.value,
  }) : super(key: key);

  final void Function(String?)? onChanged;
  final List<String> items;
  String? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: kColorWhite,
          border: Border.symmetric(
              horizontal: BorderSide(
                  width: 0.8, color: kSecondaryColor.withOpacity(0.2)))),
      child: DropdownButton<String>(
        underline: null,
        style: Theme.of(context).textTheme.bodyText1,
        items: items.map(buildMenuItem).toList(),
        value: value,
        iconSize: 34,
        isExpanded: true,
        iconEnabledColor: kSecondaryColorDark,
        onChanged: onChanged,
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        child: Text(
          item,
        ),
        value: item,
      );
}
