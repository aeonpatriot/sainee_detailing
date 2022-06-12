// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/cupertino.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/address.dart';
import 'package:sainee_detailing/services/address_service.dart';
import 'package:sainee_detailing/widget/custom_snackbar.dart';

class AddressViewModel extends ChangeNotifier {
  late Address _editingAddress;
  late Address _editingAddressCopy;
  bool _isSubmitted = false;

  final addressService = service<AddressService>();

  Address get editingAddress => _editingAddress;
  set editingAddress(Address address) => _editingAddress = address;
  Address get editingAddressCopy => _editingAddressCopy;
  set editingAddressCopy(Address address) => _editingAddressCopy = address;

  get isSubmitted => _isSubmitted;
  setIsSubmitted(value) {
    _isSubmitted = value;
    notifyListeners();
  }

  void noti() {
    notifyListeners();
  }

  Future setAddressForEdit(Address address) async {
    _editingAddress = address;
    _editingAddressCopy = Address.copy(_editingAddress);
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

  Future submitAddressDetails(BuildContext context,
      {required Address address, required dynamic resetValidationItem}) async {
    setIsSubmitted(true);
    final List<Address>? addresses =
        await addressService.createNewAddress(address);
    if (addresses == null) {
      // resetValidationItem();
      FailedSnackBar.show(
          context: context,
          title: 'Oh Snap!',
          message:
              'There is some problem creating your address. Please try again');
      setIsSubmitted(false);
    } else {
      resetValidationItem();
      Navigator.of(context).pop();
      noti();
      SuccessSnackBar.show(
          context: context,
          message: 'Your new address has been created successfully');
      setIsSubmitted(false);
      // return addresses;
    }
  }

  Future updateAddress(
      {required BuildContext context,
      required Address address,
      required dynamic resetValidationItem}) async {
    print(address);
    final json = await addressService.updateAddress(
        addressId: address.id, editedAddress: address);

    if (json == null) {
      FailedSnackBar.show(
          context: context,
          title: 'Oh Snap!',
          message:
              'There is some problem updating your address. Please try again');
      setIsSubmitted(false);
      print('update failed');
    } else {
      resetValidationItem();
      Navigator.of(context).pop();
      noti();
      SuccessSnackBar.show(
          context: context,
          message: 'Your address has been updated successfully');
      setIsSubmitted(false);
      print('update success');
    }
  }

  Future deleteAddress(
      {required BuildContext context,
      required String addressId,
      required VoidCallback resetValidationItem}) async {
    print(addressId);
    final response = await addressService.deleteAddress(addressId);

    if (response == null) {
      FailedSnackBar.show(
          context: context,
          title: 'Oh Snap!',
          message:
              'There is some problem deleting the address. Please try again');
    } else {
      resetValidationItem();
      Navigator.of(context).pop();
      Navigator.of(context)
          .pop(); //2 pop because first popo from alert dialog and second pop from the edit screen
      noti();
      SuccessSnackBar.show(
          context: context, message: 'Address has been deleted successfully');
    }
  }
}
