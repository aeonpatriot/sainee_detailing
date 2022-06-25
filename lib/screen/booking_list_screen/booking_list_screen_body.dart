import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/booking_list_screen/customer/customer_confirmed_booking_list_screen.dart';
import 'package:sainee_detailing/screen/booking_list_screen/customer/customer_history_booking_list_screen.dart';
import 'package:sainee_detailing/screen/booking_list_screen/customer/customer_new_booking_list_screen.dart';
import 'package:sainee_detailing/screen/booking_list_screen/staff/staff_confirmed_booking_list_screen.dart';
import 'package:sainee_detailing/screen/booking_list_screen/staff/staff_history_booking_list_screen.dart';
import 'package:sainee_detailing/screen/booking_list_screen/staff/staff_new_booking_list_screen.dart';
import 'package:sainee_detailing/viewmodels/bookinglist_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';

class BookingListScreenBody extends StatelessWidget {
  const BookingListScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookingListViewModel bookingListViewModel =
        Provider.of<BookingListViewModel>(context);
    final LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);

    return SizedBox(
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 39,
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    bookingListViewModel.controller.animateToPage(0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear);
                    bookingListViewModel.setCustomerBookingTab(0);
                  },
                  child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: Colors.transparent)),
                    child: Center(
                      child: Text(
                        'New',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    bookingListViewModel.controller.animateToPage(1,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear);
                    bookingListViewModel.setCustomerBookingTab(1);
                  },
                  child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            vertical: BorderSide(
                                color: Colors.grey[200]!, width: 1))),
                    child: Center(
                      child: Text(
                        'Confirmed',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                )),
                Expanded(
                    //History Tab
                    child: GestureDetector(
                  onTap: () {
                    bookingListViewModel.controller.animateToPage(2,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear);
                    bookingListViewModel.setCustomerBookingTab(2);
                  },
                  child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: Colors.transparent)),
                    child: Center(
                      child: Text(
                        'History',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0),
            height: 3,
            width: double.infinity,
            child: AnimatedAlign(
              curve: Curves.elasticOut,
              alignment: bookingListViewModel.customerBookingTab == 0
                  ? Alignment.centerLeft
                  : bookingListViewModel.customerBookingTab == 1
                      ? Alignment.center
                      : Alignment.centerRight,
              duration: const Duration(seconds: 2),
              child: Container(
                height: 3,
                width: MediaQuery.of(context).size.width / 3,
                color: kPrimaryColorDarker,
              ),
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey[350],
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: PageView(
                controller: bookingListViewModel.controller,
                onPageChanged: (page) {
                  bookingListViewModel.setCustomerBookingTab(page);
                },
                children: loginViewModel.userDetails.type == 'customer'
                    ? const [
                        CustomerNewBookingList(),
                        CustomerConfirmedBookingList(),
                        CustomerHistoryBookingList(),
                      ]
                    : const [
                        StaffNewBookingList(),
                        StaffConfirmedBookingList(),
                        StaffHistoryBookingList(),
                      ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
