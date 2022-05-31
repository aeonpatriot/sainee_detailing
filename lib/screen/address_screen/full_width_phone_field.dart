import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class CustomFullWidthIntlPhoneField extends StatelessWidget {
  const CustomFullWidthIntlPhoneField(
      {Key? key, validator, onChanged, editNumber})
      : _validator = validator,
        _onChanged = onChanged,
        _editNumber = editNumber,
        super(key: key);

  final FutureOr<String?> Function(PhoneNumber?)? _validator;
  final Function(PhoneNumber)? _onChanged;
  final String? _editNumber;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      dropdownTextStyle: Theme.of(context).textTheme.bodyText1,
      showCountryFlag: false,
      showDropdownIcon: false,
      countries: const ['MY'],
      disableLengthCheck: true,
      validator: _validator,
      initialCountryCode: 'MY',
      onChanged: _onChanged,
      style: Theme.of(context).textTheme.bodyText1,
      initialValue: _editNumber,
      decoration: InputDecoration(
          labelText: 'Phone Number',
          labelStyle: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Colors.grey.shade400),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.2))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          focusColor: Colors.transparent,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
          filled: true,
          fillColor: Colors.white,
          // errorText: '_errorText',
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 100, color: Colors.transparent),
          )),
    );
  }
}
