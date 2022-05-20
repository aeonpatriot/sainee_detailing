import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/register_screen/register_screen_body.dart';

class RegisterScreen extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (context) => RegisterScreen());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kColorOffWhite,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   iconTheme: const IconThemeData(color: Colors.black),
      //   backgroundColor: kPrimaryColor,
      //   elevation: 0.0,
      // ),
      body: RegisterScreenBody(),
    );
  }
}
