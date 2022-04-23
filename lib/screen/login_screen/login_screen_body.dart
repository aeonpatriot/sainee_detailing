import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            _buildTextBox(
                hint: 'Email',
                onChanged: (value) => {},
                prefixIcon: const Icon(Icons.person)),
            const SizedBox(height: 20),
            _buildTextBox(
                hint: 'Pasword',
                onChanged: (value) => {},
                prefixIcon: const Icon(Icons.lock)),
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
                  onTap: () => {print('alsdhfkjashdf')},
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

  SizedBox _buildTextBox({hint, onChanged, prefixIcon, suffixIcon}) {
    return SizedBox(
      width: 310.0,
      height: 55,
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(fontSize: 17.0),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5),
            borderRadius: BorderRadius.all(
              Radius.circular(7),
            ),
          ),
        ),
      ),
    );
  }
}
