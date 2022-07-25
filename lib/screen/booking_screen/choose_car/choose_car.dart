import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/booking_screen/choose_car/choose_car_body.dart';

class ChooseCarScreen extends StatelessWidget {
  const ChooseCarScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => ChooseCarScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorOffWhite,
      appBar: AppBar(
        shadowColor: kSecondaryColorDark.withOpacity(0.2),
        elevation: 2,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: kPrimaryColor,
        title: Text(
          'My Car',
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: kColorWhite),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: kColorWhite,
            icon: Icon(Icons.arrow_back)),
      ),
      body: const ChooseCarScreenBody(),
    );
  }
}
