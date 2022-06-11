import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/car_screen/car_screen_body.dart';

class CarScreen extends StatelessWidget {
  const CarScreen({Key? key}) : super(key: key);

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
        actions: [
          ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent)),
            child: Row(children: [
              Text(
                'ADD',
                style: Theme.of(context).textTheme.button,
              ),
              const SizedBox(width: 2.5),
              const Icon(Icons.add),
            ]),
            onPressed: () {
              Navigator.of(context).pushNamed('/addCar');
            },
          ),
        ],
      ),
      body: const CarScreenBody(),
    );
  }
}
