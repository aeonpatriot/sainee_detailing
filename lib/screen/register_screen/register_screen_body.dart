import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
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

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              children: const <Widget>[
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: DecoratedBox(
                      decoration: BoxDecoration(color: kPrimaryColor)),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: kColorOffWhite,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              // topRight: Radius.circular(100),
                            ))),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 310.0,
              child: Text(
                'Create Account',
                style: TextStyle(
                  color: kSecondaryColorDark,
                  fontSize: headingFont,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
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
            SizedBox(
              width: 310.0,
              child: IntlPhoneField(
                dropdownTextStyle: const TextStyle(fontSize: 15.5),
                showCountryFlag: false,
                countries: const ['MY'],
                disableLengthCheck: true,
                validator: (phoneNumber) {
                  if (phoneNumber != null &&
                      (phoneNumber.number.length < 9 ||
                          phoneNumber.number.length > 10)) {
                    registrationValidation.phoneNumber =
                        phoneNumber.completeNumber;
                    registrationValidation.setIsPhoneNumberValid(false);
                    return 'Enter valid number';
                  } else {
                    registrationValidation.setIsPhoneNumberValid(true);
                    return null;
                  }
                },
                initialCountryCode: 'MY',
                onChanged: (phoneNumber) {
                  if ((phoneNumber.number.length < 9 ||
                      phoneNumber.number.length > 10)) {
                    registrationValidation.phoneNumber =
                        phoneNumber.completeNumber;
                    registrationValidation.setIsPhoneNumberValid(false);
                  } else {
                    registrationValidation.setIsPhoneNumberValid(true);
                  }
                },
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 17, horizontal: 15),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Phone Number',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kSecondaryColorDark)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kSecondaryColorDark)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    )),
              ),
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
            Consumer<RegistrationValidation>(
              builder: (context, notifier, child) => ElevatedButton(
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
                        notifier.setIsRegisterLoading(true);
                        registrationValidation.submitRegistration(context);
                      },
                child: notifier.isRegisterLoading
                    ? SizedBox(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text('Creating Your Account'),
                            SizedBox(width: 10),
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  color: kPrimaryColorDark,
                                  backgroundColor: kPrimaryColor),
                            ),
                          ],
                        ),
                      )
                    : const Text('Sign Up'),
              ),
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
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, '/login'),
                  child: const Text(' Sign in',
                      style: TextStyle(fontSize: 15, color: kSecondaryColor)),
                ),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
