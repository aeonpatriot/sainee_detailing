import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/widget/Info_alert.dart';

class CustomFullWidthTextField extends StatelessWidget {
  final String _labelText;
  final dynamic _onChanged;
  final String? _errorText;
  final bool _isPostcode;
  final int? _maxLine;
  final String? _editAddressText;

  const CustomFullWidthTextField(
      {Key? key,
      required labelText,
      required onChanged,
      required errorText,
      required isPostcode,
      editAddressText,
      isEdit,
      maxLine})
      : _labelText = labelText,
        _onChanged = onChanged,
        _errorText = errorText,
        _isPostcode = isPostcode,
        _maxLine = maxLine,
        _editAddressText = editAddressText,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: _onChanged,
      textInputAction: TextInputAction.next,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        labelText: _labelText,
        errorText: _errorText,
        labelStyle: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(color: Colors.grey.shade400),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        focusColor: Colors.transparent,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 100, color: Colors.transparent),
        ),
      ),
      keyboardType: _isPostcode ? TextInputType.phone : null,
      maxLines: _maxLine ?? 1,
      initialValue: _editAddressText,
    );
  }
}

class LabeledSwitch extends StatelessWidget {
  const LabeledSwitch({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.isEdit,
    this.defaultAddress,
    this.originalDefaultAddress,
  }) : super(key: key);

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool? isEdit;
  final String? defaultAddress;
  final String? originalDefaultAddress;

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
        defaultAddress != null &&
        originalDefaultAddress != null) {
      if (defaultAddress == 'Y' &&
          isEdit == true &&
          originalDefaultAddress == 'Y') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

class AddressCardText extends StatelessWidget {
  const AddressCardText({
    Key? key,
    required this.text,
    this.isHeading,
    this.isDefault,
  }) : super(key: key);

  final String text;
  final bool? isHeading;
  final String? isDefault;

  static const maincontentTextColor = Color.fromRGBO(158, 158, 158, 1);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text,
          style: TextStyle(
              color: isHeading == null ? maincontentTextColor : kColorBlack,
              fontSize: kMaincontentFont),
          children: (isDefault == 'Y')
              ? [
                  const TextSpan(
                      text: ' [Default Address]',
                      style: TextStyle(color: kSecondaryColor))
                ]
              : []),
    );
  }
}

class CustomTextDivider extends StatelessWidget {
  const CustomTextDivider({
    Key? key,
    required title,
  })  : _title = title,
        super(key: key);

  final String _title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Text(
        _title,
        style: Theme.of(context)
            .textTheme
            .bodyText2
            ?.copyWith(color: Colors.black45),
      ),
    );
  }
}
