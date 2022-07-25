import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/models/address.dart';
import 'package:sainee_detailing/models/car.dart';
import 'package:sainee_detailing/models/user.dart';
import 'package:sainee_detailing/viewmodels/bookingdetails_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';

class BookingDetailsScreenBody extends StatelessWidget {
  const BookingDetailsScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookingDetailsViewModel bookingDetailsViewModel =
        Provider.of<BookingDetailsViewModel>(context);
    final LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);

    final TextStyle? themeStyle = Theme.of(context).textTheme.bodyText1;

    final TextStyle? statusTextStyle =
        themeStyle?.copyWith(fontSize: 17, color: kColorWhite);
    final TextStyle? mainTextStyle =
        Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17);
    final TextStyle? greyTextStyle =
        themeStyle?.copyWith(color: Colors.grey[600]);
    final TextStyle? secondaryTextStyle = themeStyle?.copyWith(fontSize: 16);

    final String userType = loginViewModel.userDetails.type;

    return Container(
      color: kColorOffWhite,
      height: double.infinity,
      child: FutureBuilder(
        future: bookingDetailsViewModel.futureAllBookingDetails,
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: SpinKitCubeGrid(
                  color: kPrimaryColorDarker,
                  size: 50.0,
                ),
              );
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final User user = snapshot.data[0];
                final Car car = snapshot.data[1];
                final Address address = snapshot.data[2];
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      bookingDetailsViewModel.bookingDetails.status ==
                              'COMPLETED'
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Booking Completed',
                                          style: statusTextStyle,
                                        ),
                                        userType == 'customer'
                                            ? const SizedBox(height: 10)
                                            : Container(),
                                        userType == 'customer'
                                            ? Text(
                                                'Thank you for using our service',
                                                style: statusTextStyle,
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/icons/icons8-task-completed-80.png',
                                    height: userType == 'staff' ? 50 : null,
                                    width: userType == 'staff' ? 50 : null,
                                  ),
                                  const SizedBox(width: 20),
                                ],
                              ),
                              width: double.infinity,
                              color: kSecondaryColor,
                            )
                          : bookingDetailsViewModel.bookingDetails.status ==
                                  'CANCELLED'
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Booking Cancelled',
                                        style: statusTextStyle,
                                      )
                                    ],
                                  ),
                                  width: double.infinity,
                                  color: Colors.red[700])
                              : Container(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 9, horizontal: 10),
                        color: kColorWhite,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.car_repair_outlined,
                                    size: 20,
                                    color: kPrimaryColorDarker,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Car Information',
                                    style: mainTextStyle,
                                  )
                                ],
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.only(left: 24),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${car.brand} ${car.model}',
                                        style: greyTextStyle,
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        '${car.plateNumber}', //plateNumber
                                        style: greyTextStyle,
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        'Type: ${car.type}', //type
                                        style: greyTextStyle,
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        'Description: ${car.description}', //description
                                        style: greyTextStyle,
                                      ),
                                    ]),
                              ),
                            ]),
                      ),
                      Container(
                        color: Colors.grey[300],
                        width: double.infinity,
                        height: 1,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 9, horizontal: 10),
                        color: kColorWhite,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.pin_drop_outlined,
                                    size: 20,
                                    color: kPrimaryColorDarker,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    address.id == '1'
                                        ? 'Service Location'
                                        : 'Pickup Address',
                                    style: mainTextStyle,
                                  )
                                ],
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.only(left: 24),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      address.id == '1'
                                          ? Text(
                                              'Ahmad Husaini',
                                              style: greyTextStyle,
                                            )
                                          : Text(
                                              '${address.name}',
                                              style: greyTextStyle,
                                            ),
                                      const SizedBox(height: 3),
                                      Text(
                                        '${address.phoneNumber}',
                                        style: greyTextStyle,
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        '${address.addressLine1}',
                                        style: greyTextStyle,
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        '${address.postcode} ${address.city}, ${address.state}',
                                        style: greyTextStyle,
                                      ),
                                    ]),
                              ),
                            ]),
                      ),
                      loginViewModel.userDetails.type == 'staff'
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 9, horizontal: 10),
                              color: kColorWhite,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.person_outline,
                                          size: 20,
                                          color: kPrimaryColorDarker,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Customer Details',
                                          style: mainTextStyle,
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
                                      padding: const EdgeInsets.only(left: 24),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              user.name,
                                              style: greyTextStyle,
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              user.phoneNumber,
                                              style: greyTextStyle,
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              user.email,
                                              style: greyTextStyle,
                                            ),
                                          ]),
                                    ),
                                  ]),
                            )
                          : Container(),
                      Container(
                        color: kColorOffWhite,
                        width: double.infinity,
                        height: 10,
                      ),
                      Container(
                        color: kColorWhite,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 11),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    bookingDetailsViewModel
                                        .bookingDetails.serviceName!,
                                    style: mainTextStyle,
                                  ),
                                ),
                                Text(
                                  bookingDetailsViewModel
                                      .bookingDetails.status!,
                                  style: themeStyle?.copyWith(
                                      color: kPrimaryColorDarker),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Booking Total: ',
                                  style: secondaryTextStyle,
                                )),
                                Text(
                                  'RM ${bookingDetailsViewModel.bookingDetails.totalPrice}',
                                  style: secondaryTextStyle,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Expanded(child: Text('Payment Method: ')),
                                Text(bookingDetailsViewModel
                                    .formatPaymentMethod(bookingDetailsViewModel
                                        .bookingDetails.paymentType!)),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                const Expanded(child: Text('Date Booked: ')),
                                Text(bookingDetailsViewModel.formatDate(
                                    bookingDetailsViewModel
                                        .bookingDetails.date!)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Expanded(child: Text('Time slot: ')),
                                Text(bookingDetailsViewModel.formatTimeSlot(
                                    bookingDetailsViewModel
                                        .bookingDetails.timeSlot!)),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                    child: Text('Having some problem to load data'));
              }
          }
        },
      ),
    );
  }
}
