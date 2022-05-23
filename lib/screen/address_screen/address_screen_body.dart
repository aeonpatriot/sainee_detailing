import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/models/address.dart';
import 'package:sainee_detailing/viewmodels/address_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';

class AddressScreenBody extends StatelessWidget {
  const AddressScreenBody({
    Key? key,
    required this.addressViewModel,
  }) : super(key: key);

  final AddressViewModel addressViewModel; //sama je kot

  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);

    return FutureBuilder(
      future: addressViewModel.getUserAddresses(loginViewModel.userDetails.id),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
                child: CircularProgressIndicator(color: kSecondaryColorDark));
          case ConnectionState.done:
          default:
            if (snapshot.hasError) {
              final error = snapshot.error;
              return Center(child: Text('Error: $error'));
            } else if (snapshot.hasData) {
              List<Address> data = snapshot.data as List<Address>;
              return ListView.builder(
                  padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    Address address = data[index];
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
                        child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          onTap: () {
                            // final String data = '3.1582024524710235';
                            // print(data.runtimeType);
                            // final double dData = double.parse(data);
                            // print(dData.runtimeType);
                            // print(dData * 2);
                            addressViewModel.getUserAddresses(
                                loginViewModel.userDetails.id);
                          },
                          child: SizedBox(
                            child: Stack(children: [
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                    height: 10,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: address.defaultAddress == 'N'
                                            ? Colors.transparent
                                            : kSecondaryColor,
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(20)))),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 20, bottom: 20, right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    AddressCardText(
                                        isDefault: address.defaultAddress,
                                        isHeading: true,
                                        text: address.name),
                                    const SizedBox(height: 10),
                                    AddressCardText(text: address.phoneNumber),
                                    const SizedBox(height: 5),
                                    AddressCardText(text: address.addressLine1),
                                    const SizedBox(height: 5),
                                    AddressCardText(
                                        text:
                                            '${address.city}, ${address.state}, ${address.postcode}'),
                                  ],
                                ),
                                // height: 150,
                                // width: 100,
                              ),
                            ]),
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return const Text('Having some problem to load data');
            }
        }
      },
    );
  }
}

class AddressCardText extends StatelessWidget {
  const AddressCardText({
    Key? key,
    required this.text,
    this.isHeading,
    this.isDefault,
  }) : super(key: key);

  final String text;
  final bool? isHeading;
  final String? isDefault;

  static const maincontentTextColor = Color.fromRGBO(158, 158, 158, 1);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text,
          style: TextStyle(
              color: isHeading == null ? maincontentTextColor : kColorBlack,
              fontSize: kMaincontentFont),
          children: (isDefault == 'Y')
              ? [
                  const TextSpan(
                      text: ' [Default Address]',
                      style: TextStyle(color: kSecondaryColor))
                ]
              : []),
    );
  }
}
