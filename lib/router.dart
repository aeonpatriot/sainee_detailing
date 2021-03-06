import 'package:flutter/material.dart';
import 'package:sainee_detailing/screen/address_screen/add_address_screen/add_address_screen.dart';
import 'package:sainee_detailing/screen/address_screen/address_screen.dart';
import 'package:sainee_detailing/screen/address_screen/edit_address_screen/edit_address_screen.dart';
import 'package:sainee_detailing/screen/booking_details_screen/booking_details_screen.dart';
import 'package:sainee_detailing/screen/booking_screen/booking_screen.dart';
import 'package:sainee_detailing/screen/car_screen/add_car_screen/add_car_screen.dart';
import 'package:sainee_detailing/screen/car_screen/edit_car_screen/edit_car_screen.dart';
import 'package:sainee_detailing/screen/dashboard_screen/dashboard_screen.dart';
import 'package:sainee_detailing/screen/login_screen/login_screen.dart';
import 'package:sainee_detailing/screen/main_menu_screen/main_menu.dart';
import 'package:sainee_detailing/screen/other_screen/register_success_screen.dart';
import 'package:sainee_detailing/screen/profile_screen/edit_profile_screen.dart';
import 'package:sainee_detailing/screen/profile_screen/profile_screen.dart';
import 'package:sainee_detailing/screen/register_screen/register_screen.dart';
import 'package:sainee_detailing/screen/services_screen/services_screen.dart';

Route<dynamic>? createRoute(settings) {
  switch (settings.name) {
    case '/':
      // return SplashScreen.route();
      // return MainMenuScreen.route();
      return LoginScreen.route();
    // return ProfileScreen.route();
    // return EditProfileScreen.route();
    // return AddressScreen.route();
    // return RegisterSuccessScreen.route();
    case '/login':
      return LoginScreen.route();
    case '/register':
      return RegisterScreen.route();
    case '/main':
      return MainMenuScreen.route();
    case '/dashboard':
      return DashboardScreen.route();
    case '/profile':
      return ProfileScreen.route();
    case '/editProfile':
      return EditProfileScreen.route(editType: settings.arguments);
    case '/registersuccess':
      return RegisterSuccessScreen.route();
    case '/address':
      return AddressScreen.route();
    case '/addAddress':
      return AddAddressScreen.route();
    case '/editAddress':
      return EditAddressScreen.route();
    case '/addCar':
      return AddCarScreen.route();
    case '/editCar':
      return EditCarScreen.route();
    case '/services':
      return ServicesScreen.route();
    case '/booking':
      return BookingScreen.route();
    case '/bookingDetails':
      return BookingDetailsScreen.route();
  }
  return null;
}
