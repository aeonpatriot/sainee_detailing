import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sainee_detailing/validation/address_validation.dart';
import 'package:sainee_detailing/validation/car_validation.dart';
import 'package:sainee_detailing/validation/registration_validation.dart';
import 'package:sainee_detailing/viewmodels/account_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/address_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/car_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/image_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/mainmenu_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/profile_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/register_viewmodel.dart';

import 'dependencies.dart' as di;

void main() {
  di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AddressValidation>(
          create: (context) => AddressValidation()),
      ChangeNotifierProvider<RegistrationValidation>(
          create: (context) => RegistrationValidation()),
      ChangeNotifierProvider<CarValidation>(
          create: (context) => CarValidation()),
      ChangeNotifierProvider<RegisterViewModel>(
          create: (context) => RegisterViewModel()),
      ChangeNotifierProvider<LoginViewModel>(
          create: (context) => LoginViewModel()),
      ChangeNotifierProvider<MainmenuViewModel>(
          create: (context) => MainmenuViewModel()),
      ChangeNotifierProvider<AccountViewModel>(
          create: (context) => AccountViewModel()),
      ChangeNotifierProvider<ProfileViewModel>(
          create: (context) => ProfileViewModel()),
      ChangeNotifierProvider<AddressViewModel>(
          create: (context) => AddressViewModel()),
      ChangeNotifierProvider<ImageViewModel>(
          create: (context) => ImageViewModel()),
      ChangeNotifierProvider<CarViewModel>(create: (context) => CarViewModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme.copyWith(
              // headline6: const TextStyle(color: kColorWhite),
              // bodyText1: const TextStyle(fontSize: 16),
              button: const TextStyle(
                  color: kColorWhite,
                  fontSize: 16,
                  letterSpacing: 1.25,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Sainee Detailing Services Online Booking System',
      onGenerateRoute: createRoute,
      initialRoute: '/',
    );
  }
}
