import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/viewmodels/booking_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/car_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';

class BookingScreenBottomBar extends StatelessWidget {
  const BookingScreenBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookingViewModel bookingViewModel =
        Provider.of<BookingViewModel>(context);
    final CarViewModel carViewModel =
        Provider.of<CarViewModel>(context, listen: false);
    final LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);

    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(color: Colors.white,
          // borderRadius: const BorderRadius.only(
          //     topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -1),
              blurRadius: 5,
              color: kSecondaryColorDark.withOpacity(0.2),
            ),
          ]),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 1),
            Expanded(
              child: Text.rich(
                TextSpan(text: 'Service:\n', children: [
                  TextSpan(
                      text: '${bookingViewModel.chosenService.name}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
            Text.rich(
              TextSpan(text: 'Total:\n', children: [
                TextSpan(
                    text: 'RM ' +
                        bookingViewModel.setServicePrice(
                            carType: carViewModel.defaultCar.type!,
                            service: bookingViewModel.chosenService),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ]),
            ),
            const SizedBox(width: 10),
            Container(
              color: bookingViewModel.isAllBookingDetailsChosen()
                  ? kPrimaryColorDarker
                  : Colors.grey[400],
              child: TextButton(
                style: TextButton.styleFrom(
                  elevation: 0,
                  primary: kColorWhite,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 10.0,
                  ),
                  minimumSize: const Size(150.0, 20.0),
                  textStyle: Theme.of(context).textTheme.button,
                ),
                child: Text('Book Now'.toUpperCase()),
                onPressed: bookingViewModel.isAllBookingDetailsChosen()
                    ? () {
                        bookingViewModel.createNewBooking(
                            context: context, user: loginViewModel.userDetails);
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
