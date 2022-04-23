import 'package:flutter/material.dart';
import 'package:sainee_detailing/router.dart';

void main() {
  // runApp(const SplashScreen());
  // runApp(LoginScreen());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant Booking System',
      onGenerateRoute: createRoute,
      initialRoute: '/',
    );
  }
}
