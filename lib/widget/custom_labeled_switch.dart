import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/widget/Info_alert.dart';

class LabeledSwitch extends StatelessWidget {
  const LabeledSwitch({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.isEdit,
    this.defaultValue,
    this.originalDefaultValue,
  }) : super(key: key);

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool? isEdit;
  final String? defaultValue;
  final String? originalDefaultValue;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kColorWhite,
      child: InkWell(
        splashFactory:
            _isDisabled() ? NoSplash.splashFactory : InkSplash.splashFactory,
        onTap: _isDisabled()
            ? () {
                InfoAlert.showAlertDialog(context: context);
              }
            : () {
                onChanged(!value);
              },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.grey.withOpacity(0.2))),
          height: 54.0,
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: <Widget>[
              // const SizedBox(width: 10),
              Expanded(
                  child: Text(
                label,
                style: Theme.of(context).textTheme.bodyText1,
              )),
              Switch(
                activeColor: _isDisabled() ? Colors.grey : kSecondaryColorDark,
                value: value,
                onChanged: _isDisabled()
                    ? (bool newValue) {
                        FocusScope.of(context).unfocus();
                        InfoAlert.showAlertDialog(context: context);
                      }
                    : (bool newValue) {
                        onChanged(newValue);
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isDisabled() {
    if (isEdit != null &&
        defaultValue != null &&
        originalDefaultValue != null) {
      if (defaultValue == 'Y' &&
          isEdit == true &&
          originalDefaultValue == 'Y') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
