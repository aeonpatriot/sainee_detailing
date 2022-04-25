import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/router.dart';
import 'package:sainee_detailing/validation/registration_validation.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/register_viewmodel.dart';

import 'dependencies.dart' as di;

void main() {
  di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<RegistrationValidation>(
          create: (context) => RegistrationValidation()),
      ChangeNotifierProvider<RegisterViewModel>(
          create: (context) => RegisterViewModel()),
      ChangeNotifierProvider<LoginViewModel>(
          create: (context) => LoginViewModel()),
    ],
    child: const MyApp(),
  ));
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
