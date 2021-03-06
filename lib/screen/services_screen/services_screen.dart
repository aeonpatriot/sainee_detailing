import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/services_screen/services_screen_body.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => const ServicesScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorOffWhite,
      appBar: AppBar(
        shadowColor: kSecondaryColorDark.withOpacity(0.2),
        elevation: 2,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColor,
        title: Text(
          'Services',
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: kColorWhite),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: const ServicesScreenBody(),
    );
  }
}
