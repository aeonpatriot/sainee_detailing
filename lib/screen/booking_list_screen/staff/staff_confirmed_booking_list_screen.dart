import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/models/book.dart';
import 'package:sainee_detailing/viewmodels/bookingdetails_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/bookinglist_viewmodel.dart';
import 'package:sainee_detailing/widget/custom_placeholder_empty_list.dart';
import 'package:sainee_detailing/widget/custom_shimmer_widget/staff_booking_list_shimmer.dart';

class StaffConfirmedBookingList extends StatelessWidget {
  const StaffConfirmedBookingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookingListViewModel bookingListViewModel =
        Provider.of<BookingListViewModel>(context);
    final BookingDetailsViewModel bookingDetailsViewModel =
        Provider.of<BookingDetailsViewModel>(context);

    return FutureBuilder(
      future: bookingListViewModel.futureAllConfirmedBookingList,
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return const StaffBookingListShimmerWidget();
              },
            );
          case ConnectionState.done:
          default:
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final List<Book> bookingList = snapshot.data;

              if (bookingList.isEmpty) {
                return const CustomPlaceholderEmptyList(
                  iconUrl: 'assets/icons/icons8-booking2-64.png',
                  firstText: 'Its empty here...',
                );
              } else {
                return ListView.builder(
                  itemCount: bookingList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Book booking = bookingList[index];
                    return Material(
                      child: InkWell(
                        onTap: () {
                          bookingDetailsViewModel.bookingDetails = booking;
                          bookingDetailsViewModel.setFutureAllBookingDetails(
                              userId: booking.userId!,
                              addressId: booking.addressId!,
                              carId: booking.carId!);
                          Navigator.of(context).pushNamed('/bookingDetails');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.grey[350]!))),
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        booking.userName!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(fontSize: 16),
                                      )),
                                      SizedBox(
                                        child: Text(
                                          booking.status!.toUpperCase(),
                                          textAlign: TextAlign.right,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(
                                                  fontSize: 14,
                                                  color: kPrimaryColorDarker),
                                        ),
                                      ),
                                    ],
                                  )),
                              const SizedBox(height: 5),
                              Text(
                                booking.serviceName!,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                booking.carName!,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${booking.date!}   ${bookingListViewModel.formatTimeSlot(booking.timeSlot!)}',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'Total: RM ${booking.totalPrice}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        fontSize: 16,
                                      ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            } else {
              return const Center(
                  child: Text('Having some problem to load data'));
            }
        }
      },
    );
  }
}
