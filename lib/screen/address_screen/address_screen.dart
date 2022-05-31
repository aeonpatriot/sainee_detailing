import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/screen/address_screen/address_screen_body.dart';
import 'package:sainee_detailing/viewmodels/address_viewmodel.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute(builder: (context) => const AddressScreen());

  @override
  Widget build(BuildContext context) {
    AddressViewModel addressViewModel =
        Provider.of<AddressViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: kColorOffWhite,
      appBar: AppBar(
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
              Navigator.of(context).pushNamed('/addAddress');
            },
          ),
        ],
        title: Text('My Address',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: kColorWhite)),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColor,
      ),
      body: AddressScreenBody(addressViewModel: addressViewModel),
    );
  }
}
