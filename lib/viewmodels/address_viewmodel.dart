import 'package:flutter/cupertino.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/address.dart';
import 'package:sainee_detailing/services/address_service.dart';

class AddressViewModel extends ChangeNotifier {
  late dynamic datadata;

  final addressService = service<AddressService>();

  Future testGetFutureData() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final testData = List<String>.generate(5000, (i) => 'Item $i');
    datadata = testData;
    return datadata;
    // return 'Success';
  }

  Future getAllAddress() async {
    final List<Address>? addresses = await addressService.getAllAddress();
    if (addresses == null) {
      print('get failed');
    } else {
      print('get success');
      print(addresses);
    }
  }

  Future getUserAddresses(String userId) async {
    final List<Address>? addresses =
        await addressService.getUserAddress(userId);
    if (addresses == null) {
      print('get failed');
    } else {
      print('get success');
      print(addresses);
      print(addresses.length);
      return addresses;
    }
  }
}
