import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/models/address.dart';
import 'package:sainee_detailing/viewmodels/address_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/booking_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/widget/custom_card_list.dart';
import 'package:sainee_detailing/widget/custom_placeholder_empty_list.dart';

class ChooseAddressScreenBody extends StatelessWidget {
  const ChooseAddressScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    AddressViewModel addressViewModel = Provider.of<AddressViewModel>(context);
    BookingViewModel bookingViewModel = Provider.of<BookingViewModel>(context);

    final Address noPickupAddress = Address(
        id: '1',
        userId: '9',
        name: 'staff',
        phoneNumber: '+60183784959',
        state: 'Selangor',
        city: 'Bangi',
        postcode: '43650',
        addressLine1:
            'No.8, Jalan7/3B, Seksyen 7, 43650, Bandar Baru Bangi, Selangor',
        defaultAddress: 'N',
        latitude: null,
        longitude: null,
        created_at: '2022-07-13 11:15:03',
        updated_at: '2022-07-13 11:15:10');

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 25, right: 25),
          child: CustomCardList(
            onTap: () {
              bookingViewModel.selectedAddressIndex = -1;
              bookingViewModel.setChosenAddress(address: noPickupAddress);
              Navigator.of(context).pop();
            },
            isDefault: 'N',
            isSelected: bookingViewModel.selectedAddressIndex == -1,
            textList: <Widget>[
              CustomCardListText(
                  isDefault: 'N',
                  isHeading: true,
                  text: 'No Pickup Service Needed'),
              SizedBox(height: 5),
              CustomCardListText(
                  isDefault: 'N',
                  isHeading: true,
                  text: 'Please go to this address'),
              SizedBox(height: 5),
              CustomCardListText(text: noPickupAddress.addressLine1)
            ],
          ),
        ),
        FutureBuilder(
          future:
              addressViewModel.getUserAddresses(loginViewModel.userDetails.id),
          builder: (context, snapshot) {
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
                  final error = snapshot.error;
                  return Center(child: Text('Error: $error'));
                } else if (snapshot.hasData) {
                  List<Address> data = snapshot.data as List<Address>;
                  if (data.isEmpty) {
                    return const CustomPlaceholderEmptyList(
                      iconUrl: 'assets/icons/icons8-address-100.png',
                      firstText: 'Its empty here...',
                      thirdText: 'Click the ADD + button at the top',
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding:
                          const EdgeInsets.only(top: 15, left: 25, right: 25),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        Address address = data[index];
                        return CustomCardList(
                          onTap: () {
                            bookingViewModel.selectedAddressIndex = index;
                            bookingViewModel.setChosenAddress(address: address);
                            Navigator.of(context).pop();
                          },
                          isSelected:
                              bookingViewModel.selectedAddressIndex == index,
                          isDefault: 'N',
                          textList: <Widget>[
                            CustomCardListText(
                                isDefault: address.defaultAddress,
                                isHeading: true,
                                text: address.name),
                            const SizedBox(height: 10),
                            CustomCardListText(text: address.phoneNumber),
                            const SizedBox(height: 5),
                            CustomCardListText(text: address.addressLine1),
                            const SizedBox(height: 5),
                            CustomCardListText(
                                text:
                                    '${address.city}, ${address.state}, ${address.postcode}'),
                          ],
                        );
                      });
                } else {
                  return const Center(
                      child: Text('Having some problem to load data'));
                }
            }
          },
        )
      ],
    );
  }
}
