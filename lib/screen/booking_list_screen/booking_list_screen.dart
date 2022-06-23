import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/booking_list_screen/booking_list_screen_body.dart';
import 'package:sainee_detailing/viewmodels/bookinglist_viewmodel.dart';

class BookingListScreen extends StatelessWidget {
  const BookingListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookingListViewModel bookingListViewModel =
        Provider.of<BookingListViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        shadowColor: kSecondaryColorDark.withOpacity(0.2),
        elevation: 2,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: kPrimaryColor,
        title: Text(
          'Booking List',
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: kColorWhite),
        ),
        // actions: [
        //   ElevatedButton(
        //       onPressed: () {
        //         bookingListViewModel.getCustomerNewBookingList('2');
        //       },
        //       child: const Text('TEST'))
        // ],
      ),
      body: const BookingListScreenBody(),
    );
  }
}
