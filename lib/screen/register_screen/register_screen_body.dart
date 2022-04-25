import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/validation/registration_validation.dart';
import 'package:sainee_detailing/viewmodels/register_viewmodel.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegistrationValidation registrationValidation =
        Provider.of<RegistrationValidation>(context);
    final RegisterViewModel registerViewModel =
        Provider.of<RegisterViewModel>(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            child: const Align(
              // alignment: Alignment.centerLeft,
              child: Text(
                'Create Account',
                style: TextStyle(
                  fontSize: titleFont,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          CenteredTextBox(
            hint: 'Full Name',
            isObscure: false,
            errorText: registrationValidation.name.error,
            onChanged: (value) {
              registrationValidation.setName(value);
              // registerViewModel.user.name = 'value';
            },
          ),
          const SizedBox(height: 20),
          CenteredTextBox(
            hint: 'Email',
            isObscure: false,
            errorText: registrationValidation.email.error,
            onChanged: (value) {
              registrationValidation.setEmail(value);
              // registerViewModel.user.email = 'value';
            },
          ),
          const SizedBox(height: 20),
          CenteredTextBox(
            hint: 'Password',
            isObscure: true,
            errorText: registrationValidation.password.error,
            onChanged: (value) {
              registrationValidation.setPassword(value);
              // registerViewModel.user.password = 'value';
            },
          ),
          const SizedBox(height: 20),
          CenteredTextBox(
            hint: 'Confirm Password',
            isObscure: true,
            errorText: registrationValidation.confirmPassword.error,
            onChanged: (value) {
              registrationValidation.setConfirmPassword(value);
            },
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: kPrimaryColorDarker,
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 10.0,
                ),
                minimumSize: const Size(310.0, 35.0),
                textStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                )),
            onPressed: (!registrationValidation.isValid)
                ? null
                : registrationValidation.submitRegistration,
            child: const Text('REGISTER'),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already have an account?',
                style: TextStyle(fontSize: 15.0),
              ),
              GestureDetector(
                onTap: () => {print('alsdhfkjashdf')},
                child: const Text(' Sign in',
                    style: TextStyle(fontSize: 15, color: Colors.blueAccent)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CenteredTextBox extends StatelessWidget {
  final String _hint;
  final bool _isObscure;
  final String? _errorText;
  final dynamic _onChange;

  CenteredTextBox({hint, isObscure, errorText, onChanged})
      : _hint = hint,
        _isObscure = isObscure,
        _errorText = errorText,
        _onChange = onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310.0,
      child: TextField(
        obscureText: _isObscure,
        onChanged: _onChange,
        style: const TextStyle(fontSize: 17.0),
        decoration: InputDecoration(
            // suffixIcon: Icon(Icons.visibility),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
            filled: true,
            fillColor: Colors.white,
            labelText: _hint,
            errorText: _errorText,
            border: const OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            )),
      ),
    );
  }
}
