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
    Provider.of<RegistrationValidation>(context, listen: false);
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
            Hero(
              tag: 'header',
              child: Material(
                type: MaterialType.transparency,
                child: Stack(
                  children: const <Widget>[
                    SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                        color: kPrimaryColor,
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [kPrimaryColor, kPrimaryColorDark]),
                      )),
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
              ),
            ),
            const SizedBox(
              width: 310.0,
              child: Hero(
                tag: 'title',
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      color: kSecondaryColorDark,
                      fontSize: kHeadingFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Consumer<RegistrationValidation>(
              builder: (context, notifier, child) => CenteredTextBox(
                hint: 'Full Name',
                isObscure: false,
                errorText: notifier.name.error,
                onChanged: (value) {
                  notifier.setName(value);
                },
              ),
            ),
            const SizedBox(height: 20),
            Consumer<RegistrationValidation>(
              builder: (context, notifier, child) => CenteredTextBox(
                hint: 'Email',
                isObscure: false,
                errorText: notifier.email.error,
                onChanged: (value) {
                  notifier.setEmail(value);
                },
              ),
            ),
            const SizedBox(height: 20),
            Consumer<RegistrationValidation>(
              builder: (context, notifier, child) => SizedBox(
                width: 310.0,
                child: IntlPhoneField(
                  style: Theme.of(context).textTheme.bodyText1,
                  dropdownTextStyle: Theme.of(context).textTheme.bodyText1,
                  showCountryFlag: false,
                  countries: const ['MY'],
                  disableLengthCheck: true,
                  validator: (phoneNumber) {
                    if (phoneNumber != null &&
                        (phoneNumber.number.length < 9 ||
                            phoneNumber.number.length > 10)) {
                      notifier.phoneNumber = phoneNumber.completeNumber;
                      notifier.setIsPhoneNumberValid(false);
                      return 'Enter valid number';
                    } else {
                      notifier.setIsPhoneNumberValid(true);
                      return null;
                    }
                  },
                  initialCountryCode: 'MY',
                  onChanged: (phoneNumber) {
                    if ((phoneNumber.number.length < 9 ||
                        phoneNumber.number.length > 10)) {
                      notifier.phoneNumber = phoneNumber.completeNumber;
                      notifier.setIsPhoneNumberValid(false);
                    } else {
                      notifier.setIsPhoneNumberValid(true);
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
            ),
            const SizedBox(height: 20),
            Consumer<RegistrationValidation>(
              builder: (context, notifier, child) => CenteredTextBox(
                hint: 'Password',
                isObscure: registerViewModel.hidePasword,
                errorText: notifier.password.error,
                suffixIcon: IconButton(
                    onPressed: registerViewModel.setHidePassword,
                    icon: registerViewModel.hidePasword
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off)),
                onChanged: (value) {
                  notifier.setPassword(value);
                },
              ),
            ),
            const SizedBox(height: 20),
            Consumer<RegistrationValidation>(
              builder: (context, notifier, child) => CenteredTextBox(
                hint: 'Confirm Password',
                isObscure: registerViewModel.hideConfirmPassword,
                suffixIcon: IconButton(
                    onPressed: registerViewModel.setHideConfirmPassword,
                    icon: registerViewModel.hideConfirmPassword
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off)),
                errorText: notifier.confirmPassword.error,
                onChanged: (value) {
                  notifier.setConfirmPassword(value);
                },
              ),
            ),
            const SizedBox(height: 40),
            Hero(
              tag: 'mainButton',
              child: Consumer<RegistrationValidation>(
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
                  onPressed: (!notifier.isValid)
                      ? null
                      : () {
                          FocusScope.of(context).unfocus();
                          notifier.setIsRegisterLoading(true);
                          notifier.submitRegistration(context);
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
                      : Text('SIGN UP',
                          style: Theme.of(context).textTheme.button),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(' Sign in',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: kSecondaryColor)),
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
