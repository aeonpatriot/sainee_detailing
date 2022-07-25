import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/booking_screen/choose_address/choose_address_body.dart';
import 'package:sainee_detailing/viewmodels/address_viewmodel.dart';

class ChooseAddressScreen extends StatelessWidget {
  const ChooseAddressScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => ChooseAddressScreen());

  @override
  Widget build(BuildContext context) {
    AddressViewModel addressViewModel =
        Provider.of<AddressViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: kColorOffWhite,
      appBar: AppBar(
        title: Text('Choose Address',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: kColorWhite)),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColor,
      ),
      body: ChooseAddressScreenBody(),
    );
  }
}
