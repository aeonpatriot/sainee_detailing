import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          ),
          const SizedBox(height: 20),
          CenteredTextBox(
            hint: 'Username',
            isObscure: false,
          ),
          const SizedBox(height: 20),
          CenteredTextBox(
            hint: 'Email',
            isObscure: false,
          ),
          const SizedBox(height: 20),
          CenteredTextBox(
            hint: 'Password',
            isObscure: true,
          ),
          const SizedBox(height: 20),
          CenteredTextBox(
            hint: 'Confirm Password',
            isObscure: true,
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
            onPressed: () {
              print('sdfsdfsdfsdfsf');
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

  CenteredTextBox({hint, isObscure})
      : _hint = hint,
        _isObscure = isObscure;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310.0,
      child: TextField(
        obscureText: _isObscure,
        onChanged: (value) {},
        style: const TextStyle(fontSize: 20.0),
        decoration: InputDecoration(
            suffixIcon: Icon(Icons.lock),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
            filled: true,
            fillColor: Colors.white,
            labelText: _hint,
            border: const OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            )),
      ),
    );
  }
}
