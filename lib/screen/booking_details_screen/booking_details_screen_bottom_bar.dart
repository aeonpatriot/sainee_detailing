import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/viewmodels/bookingdetails_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/bookinglist_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/widget/custom_alert_dialog_widget/confirm_alert.dart';

class BookingDetailsScreenBottomBar extends StatelessWidget {
  const BookingDetailsScreenBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    final BookingDetailsViewModel bookingDetailsViewModel =
        Provider.of<BookingDetailsViewModel>(context, listen: false);
    final BookingListViewModel bookingListViewModel =
        Provider.of<BookingListViewModel>(context, listen: false);

    final String userType = loginViewModel.userDetails.type;
    final String bookingStatus = bookingDetailsViewModel.bookingDetails.status!;

    final bool isStaffAndPending =
        (userType == 'staff' && bookingStatus == 'PENDING') ? true : false;
    final bool isStaffAndConfirmed =
        (userType == 'staff' && bookingStatus == 'CONFIRMED') ? true : false;
    final bool isCustomerAndPending =
        (userType == 'customer' && bookingStatus == 'PENDING') ? true : false;
    final bool isCustomerAndConfirmed = (userType == 'customer' &&
            (bookingStatus == 'CONFIRMED' ||
                bookingStatus == 'COMPLETED' ||
                bookingStatus == 'CANCELLED'))
        ? true
        : false;
    final bool isStaffAndCompleted = (userType == 'staff' &&
            (bookingStatus == 'COMPLETED' || bookingStatus == 'CANCELLED'))
        ? true
        : false;

    return Container(
      height: 50,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: isCustomerAndConfirmed
            ? Colors.transparent
            : isStaffAndCompleted
                ? Colors.transparent
                : Colors.white,
        boxShadow: isCustomerAndConfirmed
            ? []
            : isStaffAndCompleted
                ? []
                : [
                    BoxShadow(
                      offset: const Offset(0, -1),
                      blurRadius: 5,
                      color: kSecondaryColorDark.withOpacity(0.2),
                    ),
                  ],
      ),
      child: SafeArea(
        child: isStaffAndPending
            ? BookingDetailsButtonWidget(
                buttonText: Text('CONFIRM BOOKING'.toUpperCase()),
                onTap: () {
                  CustomAlertDialog.showAlertDialog(
                      alertText: 'Confirm Booking?',
                      context: context,
                      buttonText: 'Confirm',
                      onButtonPressed: () {
                        bookingDetailsViewModel.updateBookingStatus(
                            failMessage: 'Fail to confirm booking',
                            context: context,
                            status: 'CONFIRMED',
                            setBookingList:
                                bookingListViewModel.setFutureAllBookingList);
                      });
                },
              )
            : isStaffAndConfirmed
                ? BookingDetailsButtonWidget(
                    buttonText: Text('COMPLETE'.toUpperCase()),
                    onTap: () {
                      CustomAlertDialog.showAlertDialog(
                          alertText: 'Complete Booking?',
                          context: context,
                          buttonText: 'Complete',
                          onButtonPressed: () {
                            bookingDetailsViewModel.updateBookingStatus(
                                failMessage: 'Fail to complete booking',
                                context: context,
                                status: 'COMPLETED',
                                setBookingList: bookingListViewModel
                                    .setFutureAllBookingList);
                          });
                    },
                  )
                : isCustomerAndPending
                    ? BookingDetailsButtonWidget(
                        buttonText: Text('CANCEL BOOKING'.toUpperCase()),
                        onTap: () {
                          CustomAlertDialog.showAlertDialog(
                              alertText: 'Cancel Booking?',
                              context: context,
                              buttonText: 'Cancel',
                              onButtonPressed: () {
                                bookingDetailsViewModel
                                    .updateCustomerBookingStatus(
                                        userId: loginViewModel.userDetails.id,
                                        context: context,
                                        status: 'CANCELLED',
                                        setBookingList: bookingListViewModel
                                            .setFutureCustomerBookingList);
                              });
                        },
                      )
                    : Container(),
      ),
    );
  }
}

class BookingDetailsButtonWidget extends StatelessWidget {
  const BookingDetailsButtonWidget({
    Key? key,
    required this.buttonText,
    this.onTap,
  }) : super(key: key);

  final Widget buttonText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColorDarker,
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
        child: buttonText,
        onPressed: onTap,
      ),
    );
  }
}
