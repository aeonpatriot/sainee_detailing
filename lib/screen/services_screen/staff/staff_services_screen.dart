import 'package:flutter/material.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/services_screen/staff/staff_services_screen_body.dart';

class StaffServicesScreen extends StatelessWidget {
  const StaffServicesScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => const StaffServicesScreen());

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
        actions: <Widget>[
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
              Navigator.of(context).pushNamed('/addService');
            },
          ),
        ],
      ),
      body: const StaffServicesScreenBody(),
    );
  }
}
