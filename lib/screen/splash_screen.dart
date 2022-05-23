import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static Route route({user}) =>
      MaterialPageRoute(builder: (context) => const SplashScreen());

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
        () => Navigator.pushReplacement(context, LoginScreen.route()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: kColorBlack.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(15)),
                  child: Image.asset(
                    'assets/images/logo_magicwand.png',
                    semanticLabel: 'Sainee Detailing Logo',
                    height: 150.0,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
