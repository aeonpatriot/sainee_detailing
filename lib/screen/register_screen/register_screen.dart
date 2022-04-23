import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/register_screen/register_screen_body.dart';

class RegisterScreen extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (context) => RegisterScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
      ),
      body: RegisterScreenBody(),
    );
  }
}
