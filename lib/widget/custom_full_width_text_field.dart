import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sainee_detailing/constant.dart';

class CustomFullWidthTextField extends StatelessWidget {
  final String _labelText;
  final dynamic _onChanged;
  final String? _errorText;
  final bool _isNumber;
  final bool _isRinggit;
  final bool _isAutoFocus;
  final int? _maxLine;
  final String? _editText;

  const CustomFullWidthTextField(
      {Key? key,
      required labelText,
      required onChanged,
      required errorText,
      bool? isNumber,
      bool? isRinggit,
      bool? isAutoFocus,
      editext,
      isEdit,
      maxLine})
      : _labelText = labelText,
        _onChanged = onChanged,
        _errorText = errorText,
        _isAutoFocus = isAutoFocus ?? false,
        _isNumber = isNumber ?? false,
        _isRinggit = isRinggit ?? false,
        _maxLine = maxLine,
        _editText = editext,
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
            borderSide: BorderSide(
                width: 0.8, color: kSecondaryColor.withOpacity(0.2))),
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
      keyboardType: _isNumber ? TextInputType.number : null,
      inputFormatters: _isRinggit
          ? [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))]
          : null,
      maxLines: _maxLine ?? 1,
      initialValue: _editText,
      autofocus: _isAutoFocus,
    );
  }
}

class CustomTextDivider extends StatelessWidget {
  const CustomTextDivider({
    Key? key,
    required title,
    bool? isInfo,
  })  : _title = title,
        isInfo = isInfo ?? false,
        super(key: key);

  final String _title;
  final bool isInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      padding: isInfo
          ? const EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 0)
          : const EdgeInsets.all(10),
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
