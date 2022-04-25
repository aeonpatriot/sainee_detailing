import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/widget/centered_textbox.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.jpg',
              semanticLabel: 'Sainee Detailing Logo',
              height: 150.0,
            ),
            const SizedBox(height: 10),
            const Text(
              'Sainee Detailing',
              style: TextStyle(
                fontSize: titleFont,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Consumer<LoginViewModel>(
              builder: (context, notifier, child) => CenteredTextBox(
                  hint: 'Email',
                  isObscure: false,
                  onChanged: (value) => notifier.email = value,
                  prefixIcon: const Icon(Icons.mail)),
            ),
            const SizedBox(height: 20),
            Consumer<LoginViewModel>(
              builder: (context, notifier, child) => CenteredTextBox(
                hint: 'Pasword',
                onChanged: (value) => notifier.password = value,
                isObscure: notifier.hidePassword ? true : false,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: notifier.setHidePassword,
                  icon: notifier.hidePassword
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
              ),
            ),
            const SizedBox(height: 30),
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
              onPressed: loginViewModel.onLoginPressed,
              child: const Text('LOGIN'),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Dont\'t have an account?',
                  style: TextStyle(fontSize: 15),
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, '/register'),
                  child: const Text('  Create account',
                      style: TextStyle(fontSize: 15, color: Colors.blueAccent)),
                ),
              ],
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
