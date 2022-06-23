import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/models/service.dart';
import 'package:sainee_detailing/viewmodels/booking_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/car_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/service_viewmodel.dart';

class ServicesScreenBody extends StatelessWidget {
  const ServicesScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ServiceViewModel serviceViewModel =
        Provider.of<ServiceViewModel>(context);
    final CarViewModel carViewModel = Provider.of<CarViewModel>(context);
    final BookingViewModel bookingViewModel =
        Provider.of<BookingViewModel>(context, listen: false);

    return FutureBuilder(
      future: serviceViewModel.getServices(),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
                child: SpinKitCubeGrid(
              color: kSecondaryColor,
              size: 50.0,
            ));
          case ConnectionState.done:
          default:
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              List<Service> data = snapshot.data as List<Service>;
              return ListView.builder(
                  padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color:
                                kSecondaryColorDark.withOpacity(0.1), //shadow
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: kColorWhite,
                        child: Container(
                          padding: const EdgeInsets.all(0),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 6,
                                  fit: FlexFit.tight,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 15,
                                        left: 20,
                                        bottom: 20,
                                        right: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(data[index].name!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6),
                                        const SizedBox(height: 10),
                                        ...serviceViewModel.getTextDetailsList(
                                            data[index].details!),
                                      ],
                                    ),
                                    // height: 150,
                                    // width: 100,
                                  ),
                                ),
                                Flexible(
                                  flex: 4,
                                  fit: FlexFit.tight,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 15,
                                        left: 20,
                                        bottom: 20,
                                        right: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                'RM ' +
                                                    serviceViewModel
                                                        .setServicePrice(
                                                            carType:
                                                                carViewModel
                                                                    .defaultCar
                                                                    .type!,
                                                            service:
                                                                data[index]),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6),
                                            const SizedBox(width: 1),
                                            DropdownButtonHideUnderline(
                                                child: DropdownButton2(
                                              customItemsHeight: 3,
                                              itemHeight: 20,
                                              itemPadding:
                                                  const EdgeInsets.only(
                                                      left: 16, right: 16),
                                              dropdownWidth: 160,
                                              dropdownPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6),
                                              dropdownDecoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: kColorWhite,
                                              ),
                                              dropdownElevation: 2,
                                              offset: const Offset(0, 8),
                                              onChanged: (value) {},
                                              items: otherTypePriceItem(
                                                  data[index]),
                                              customButton: const Icon(
                                                Icons.info_outlined,
                                                size: 20,
                                                color: kSecondaryColor,
                                              ),
                                            ))
                                          ],
                                        ),
                                        Text(
                                            '* Price based on default car type',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                ?.copyWith(fontSize: 11)),
                                        const SizedBox(height: 5),
                                        Center(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: kPrimaryColorDarker,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 10.0,
                                                ),
                                                fixedSize:
                                                    const Size(100.0, 35.0),
                                                textStyle: const TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            child: const Text('CHOOSE'),
                                            onPressed: () {
                                              bookingViewModel.setPastTimeSlot(
                                                  DateTime.now());
                                              bookingViewModel
                                                      .timeAvailability =
                                                  bookingViewModel
                                                      .checkTimeAvailability(
                                                          DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(DateTime
                                                                  .now()));
                                              bookingViewModel
                                                  .setBookingDetails(
                                                      service: data[index]);
                                              bookingViewModel.chosenService =
                                                  data[index];
                                              Navigator.of(context)
                                                  .pushNamed('/booking');
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                  child: Text('Having some problem to load data'));
            }
        }
      },
    );
  }

  List<DropdownMenuItem<String>>? otherTypePriceItem(Service service) {
    final List<DropdownMenuItem<String>>? otherPrices;
    otherPrices = [
      const DropdownMenuItem(
        child: Text('Other Prices'),
        value: 'small',
      ),
      DropdownMenuItem(
        child: Text('Small: RM ${service.smallPrice}'),
        value: 'small',
      ),
      DropdownMenuItem(
        child: Text('Medium: RM ${service.mediumPrice}'),
        value: 'small',
      ),
      DropdownMenuItem(
        child: Text('Large: RM ${service.largePrice}'),
        value: 'small',
      ),
      DropdownMenuItem(
        child: Text('SUV: RM ${service.suvPrice}'),
        value: 'small',
      ),
      DropdownMenuItem(
        child: Text('MPV: RM ${service.mpvPrice}'),
        value: 'small',
      ),
    ];
    return otherPrices;
  }
}
