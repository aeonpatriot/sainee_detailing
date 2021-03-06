import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';

class CenteredTextBox extends StatelessWidget {
  final String _hint;
  final bool _isObscure;
  final String? _errorText;
  final dynamic _onChange;
  final dynamic _suffixIcon;
  final Icon? _prefixIcon;

  const CenteredTextBox(
      {Key? key,
      required hint,
      required isObscure,
      errorText,
      onChanged,
      suffixIcon,
      prefixIcon})
      : _hint = hint,
        _isObscure = isObscure,
        _errorText = errorText,
        _suffixIcon = suffixIcon,
        _prefixIcon = prefixIcon,
        _onChange = onChanged,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310.0,
      child: TextField(
        cursorColor: kSecondaryColorDark,
        obscureText: _isObscure,
        onChanged: _onChange,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
            focusColor: kSecondaryColorDark,
            suffixIcon: _suffixIcon,
            prefixIcon: _prefixIcon,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
            filled: true,
            fillColor: Colors.white,
            labelText: _hint,
            errorText: _errorText,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: kSecondaryColorDark)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: kSecondaryColorDark)),
            border: const OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            )),
      ),
    );
  }
}
