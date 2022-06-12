import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/login_screen/login_screen_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => const LoginScreen());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: kColorOffWhite,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   iconTheme: const IconThemeData(color: Colors.black),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      // ),
      body: LoginScreenBody(),
    );
  }
}
