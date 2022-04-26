import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/login_screen/login_screen.dart';

class RegisterSuccessScreen extends StatefulWidget {
  static Route route({user}) =>
      MaterialPageRoute(builder: (context) => RegisterSuccessScreen());

  @override
  _RegisterSuccessScreenState createState() => _RegisterSuccessScreenState();
}

class _RegisterSuccessScreenState extends State<RegisterSuccessScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
        () => Navigator.pushReplacement(context, LoginScreen.route()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorDark,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Column(
            children: const [
              Text(
                'Your registration is Successful!',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Please login now',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 100),
              Text('You will be redirected to Login Screen in a moment'),
            ],
          ))
        ],
      ),
    );
  }
}
