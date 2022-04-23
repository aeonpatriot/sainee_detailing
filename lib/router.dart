import 'package:flutter/material.dart';
import 'package:sainee_detailing/screen/login_screen/login_screen.dart';
import 'package:sainee_detailing/screen/register_screen/register_screen.dart';
import 'package:sainee_detailing/screen/splash_screen.dart';

Route<dynamic> createRoute(settings) {
  // switch (settings.name) {
  //   case '/':
  //     return SplashScreen.route();
  // }
  // return SplashScreen.route();
  // return LoginScreen.route();
  return RegisterScreen.route();
}
