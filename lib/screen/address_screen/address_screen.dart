import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
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
      appBar: AppBar(
        title: const Text('My Address'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColor,
      ),
      body: FutureBuilder(
        future: addressViewModel.testGetFutureData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                final error = snapshot.error;
                return Text('Error: $error');
              } else if (snapshot.hasData) {
                dynamic data = snapshot.data;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Text('${data[index]}'),
                      );
                    });
              } else {
                return const Text('Having some problem to load data');
              }
          }
        },
      ),
    );
  }
}
