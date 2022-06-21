import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/booking_screen/booking_screen_body.dart';
import 'package:sainee_detailing/screen/booking_screen/booking_screen_bottom_bar.dart';
import 'package:sainee_detailing/viewmodels/booking_viewmodel.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => const BookingScreen());

  @override
  Widget build(BuildContext context) {
    final BookingViewModel bookingViewModel =
        Provider.of<BookingViewModel>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        bookingViewModel.resetBookingDetails();
        return false;
      },
      child: Scaffold(
        backgroundColor: kColorOffWhite,
        appBar: AppBar(
          shadowColor: kSecondaryColorDark.withOpacity(0.2),
          elevation: 2,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
          iconTheme: const IconThemeData(color: kPrimaryColorDarker),
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                bookingViewModel.resetBookingDetails();
              },
              icon: const Icon(Icons.arrow_back)),
          actions: const <Widget>[],
          actionsIconTheme: const IconThemeData(color: kPrimaryColorDarker),
          title: const Text('Booking'),
        ),
        body: const BookingScreenBody(),
        bottomNavigationBar: const BookingScreenBottomBar(),
      ),
    );
  }
}
