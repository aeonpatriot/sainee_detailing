import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/booking_details_screen/booking_details_screen_body.dart';
import 'package:sainee_detailing/screen/booking_details_screen/booking_details_screen_bottom_bar.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => const BookingDetailsScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorOffWhite,
      appBar: AppBar(
          shadowColor: kSecondaryColorDark.withOpacity(0.2),
          elevation: 2,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
          iconTheme: const IconThemeData(color: kPrimaryColorDarker),
          backgroundColor: Colors.white,
          title: Text(
            'Booking Details',
            style: Theme.of(context).textTheme.headline6,
          )),
      body: const BookingDetailsScreenBody(),
      bottomNavigationBar: const BookingDetailsScreenBottomBar(),
    );
  }
}
