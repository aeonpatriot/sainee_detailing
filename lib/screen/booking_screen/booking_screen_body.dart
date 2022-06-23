import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/viewmodels/booking_viewmodel.dart';
import 'package:sainee_detailing/widget/custom_calendar_widget/custom_calendar.dart';
import 'package:sainee_detailing/widget/custom_icon.dart';
import 'package:sainee_detailing/widget/select_card.dart';
import 'package:sainee_detailing/widget/time_slot_card.dart';

class BookingScreenBody extends StatelessWidget {
  const BookingScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    final BookingViewModel bookingViewModel =
        Provider.of<BookingViewModel>(context);

    paymentMethodAnimation() {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    }

    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          bookingViewModel.chosenAddress != null
              ? SelectCard(
                  mainText: bookingViewModel.chosenAddress?.addressLine1,
                  titleText: 'Location for Pickup',
                  mainIcon: Icons.location_on,
                  iconSize: 19,
                )
              : Container(),
          const SizedBox(height: 15),
          bookingViewModel.chosenCar != null
              ? SelectCard(
                  mainText:
                      '${bookingViewModel.chosenCar!.brand!} ${bookingViewModel.chosenCar!.model!}, ${bookingViewModel.chosenCar!.plateNumber!}',
                  titleText: 'Car for Detailing',
                  mainIcon: Icons.directions_car_filled,
                  iconSize: 19,
                )
              : Container(),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.only(top: 10, left: 18, right: 18),
            width: double.infinity,
            color: kColorWhite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Select Date',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontSize: 19),
                ),
                SizedBox(
                  height: 100,
                  child: AnimatedHorizontalCalendar(
                      tableCalenderIcon: const Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      ),
                      tableCalenderButtonColor: kPrimaryColorDark,
                      date: DateTime.now(),
                      textColor: Colors.black45,
                      backgroundColor: Colors.white,
                      tableCalenderThemeData: ThemeData.light().copyWith(
                        primaryColor: kPrimaryColorDark,
                        buttonTheme: const ButtonThemeData(
                            textTheme: ButtonTextTheme.primary),
                        colorScheme:
                            const ColorScheme.light(primary: kPrimaryColorDark)
                                .copyWith(secondary: Colors.red),
                      ),
                      selectedColor: kSecondaryColor,
                      unSelectedBoxShadow: BoxShadow(
                        color: kSecondaryColor.withOpacity(0.25),
                        spreadRadius: 0.0,
                        blurRadius: 10,
                        offset:
                            const Offset(0, 4), // changes position of shadow
                      ),
                      initialDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      onDateSelected: (formattedDate, date) {
                        bookingViewModel.setPastTimeSlot(date);
                        bookingViewModel.chosenDate = formattedDate;
                        bookingViewModel.setTimeAvailabilityData(formattedDate);
                        bookingViewModel.setShowPaymentMethod(false);
                        bookingViewModel.paymentMethod = 0;
                      }),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pick time slot',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          child: Row(children: [
                            Container(
                              height: 15,
                              width: 15,
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Booked',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 13),
                            ),
                          ]),
                        ),
                        SizedBox(
                          child: Row(children: [
                            Container(
                              height: 15,
                              width: 15,
                              decoration: const BoxDecoration(
                                  color: Colors.green, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Available',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 13),
                            ),
                          ]),
                        ),
                        SizedBox(
                          child: Row(children: [
                            Container(
                              height: 15,
                              width: 15,
                              decoration: const BoxDecoration(
                                  color: kSecondaryColor,
                                  shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Selected',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 13),
                            ),
                          ]),
                        )
                      ]),
                ),
                const SizedBox(height: 10),
                FutureBuilder(
                  future: bookingViewModel.timeAvailability,
                  // initialData: InitialData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Column(
                          children: const [
                            SizedBox(height: 52 / 2),
                            Center(
                                child: SizedBox(
                              child: SpinKitThreeInOut(
                                color: kPrimaryColorDarker,
                                size: 20.0,
                              ),
                            )),
                            SizedBox(height: 52 / 2),
                          ],
                        );
                      case ConnectionState.done:
                      default:
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (snapshot.hasData) {
                          final data = snapshot.data;
                          // print(data[0]['id']);
                          return Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              // decoration: BoxDecoration(
                              //     border: Border.all(color: Colors.red, width: 1)),
                              // height: 100,
                              width: double.infinity,
                              child: TimeSlotCard(
                                onSelectedTimeSlot: (String slot) {
                                  bookingViewModel.chosenTimeSlot = slot;
                                  bookingViewModel.setShowPaymentMethod(true);
                                  paymentMethodAnimation();
                                },
                                typeTimeSlot: bookingViewModel
                                        .isPastSecondTimeSlot
                                    ? []
                                    : bookingViewModel.isPastFirstTimeSlot
                                        ? [bookingViewModel.smallTimeSlot.last]
                                        : bookingViewModel.smallTimeSlot,
                                futureTimeAvailability: data,
                                isPastFirstTimeSlot:
                                    bookingViewModel.isPastFirstTimeSlot,
                                isPastSecondTimeSlot:
                                    bookingViewModel.isPastSecondTimeSlot,
                              ));
                        } else {
                          return const Center(
                            child: Text('have some problem retrieving data'),
                          );
                        }
                    }
                  },
                ),
                const SizedBox(height: 10),
                bookingViewModel.showPaymentMethod
                    ? SizedBox(
                        width: double.infinity,
                        // height: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Payment Method',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 16),
                            ),
                            ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                CustomRadioListTile(
                                  value: 1,
                                  radioText: 'Pay online after service',
                                  iconUrl:
                                      'assets/icons/icons8-online-payment-48.png',
                                  paymentMethodvalue:
                                      bookingViewModel.paymentMethod,
                                  onChanged: (value) {
                                    bookingViewModel.setPaymentMethod(1);
                                  },
                                ),
                                CustomRadioListTile(
                                  value: 2,
                                  radioText: 'Pay cash after service',
                                  iconUrl: 'assets/icons/icons8-cash-48.png',
                                  paymentMethodvalue:
                                      bookingViewModel.paymentMethod,
                                  onChanged: (value) {
                                    bookingViewModel.setPaymentMethod(2);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomRadioListTile extends StatelessWidget {
  const CustomRadioListTile({
    Key? key,
    required this.paymentMethodvalue,
    this.onChanged,
    this.iconUrl,
    required this.radioText,
    required this.value,
  }) : super(key: key);

  final int paymentMethodvalue;
  final void Function(Object?)? onChanged;
  final String? iconUrl;
  final String radioText;
  final int value;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: value,
      title: Text(
        radioText,
        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
      ),
      secondary: iconUrl != null
          ? CustomIcon(
              height: 30.0,
              width: 30.0,
              label: 'online',
              imageUrl: iconUrl!,
            )
          : null,
      controlAffinity: ListTileControlAffinity.trailing,
      groupValue: paymentMethodvalue,
      onChanged: onChanged,
      activeColor: kSecondaryColor,
    );
  }
}
