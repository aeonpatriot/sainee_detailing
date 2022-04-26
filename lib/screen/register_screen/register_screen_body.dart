import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/validation/registration_validation.dart';
import 'package:sainee_detailing/viewmodels/register_viewmodel.dart';
import 'package:sainee_detailing/widget/centered_textbox.dart';

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
            },
          ),
          const SizedBox(height: 20),
          CenteredTextBox(
            hint: 'Email',
            isObscure: false,
            errorText: registrationValidation.email.error,
            onChanged: (value) {
              registrationValidation.setEmail(value);
            },
          ),
          const SizedBox(height: 20),
          CenteredTextBox(
            hint: 'Password',
            isObscure: registerViewModel.hidePasword,
            errorText: registrationValidation.password.error,
            suffixIcon: IconButton(
                onPressed: registerViewModel.setHidePassword,
                icon: registerViewModel.hidePasword
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off)),
            onChanged: (value) {
              registrationValidation.setPassword(value);
            },
          ),
          const SizedBox(height: 20),
          CenteredTextBox(
            hint: 'Confirm Password',
            isObscure: registerViewModel.hideConfirmPassword,
            suffixIcon: IconButton(
                onPressed: registerViewModel.setHideConfirmPassword,
                icon: registerViewModel.hideConfirmPassword
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off)),
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
                : () {
                    registrationValidation.submitRegistration(context);
                  },
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
                onTap: () => Navigator.pushReplacementNamed(context, '/login'),
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
