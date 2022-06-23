import 'package:flutter/Material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sainee_detailing/constant.dart';
import 'package:sainee_detailing/models/address.dart';
import 'package:sainee_detailing/validation/address_validation.dart';
import 'package:sainee_detailing/viewmodels/address_viewmodel.dart';
import 'package:sainee_detailing/viewmodels/login_viewmodel.dart';
import 'package:sainee_detailing/widget/custom_card_list.dart';
import 'package:sainee_detailing/widget/custom_placeholder_empty_list.dart';

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
    AddressViewModel addressViewModel = Provider.of<AddressViewModel>(context);
    AddressValidation addressValidation =
        Provider.of<AddressValidation>(context, listen: false);

    return FutureBuilder(
      future: addressViewModel.getUserAddresses(loginViewModel.userDetails.id),
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
                  padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    Address address = data[index];
                    return CustomCardList(
                      onTap: () async {
                        addressValidation.setValidationItemEdit(
                            address: address);
                        await addressViewModel.setAddressForEdit(address);
                        Navigator.of(context).pushNamed('/editAddress');
                      },
                      isDefault: address.defaultAddress,
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
    );
  }
}
