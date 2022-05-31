import 'package:flutter/cupertino.dart';
import 'package:sainee_detailing/models/address.dart';
import 'package:sainee_detailing/validation/validation_item.dart';

class AddressValidation extends ChangeNotifier {
  ValidationItem _name = ValidationItem(null, null);
  ValidationItem _state = ValidationItem(null, null);
  ValidationItem _city = ValidationItem(null, null);
  ValidationItem _postcode = ValidationItem(null, null);
  ValidationItem _detailAddress = ValidationItem(null, null);
  String? _phoneNumber;
  bool _isPhoneNumberValid = false;
  bool _defaultAddressToggled = false;

  ValidationItem get name => _name;
  ValidationItem get state => _state;
  ValidationItem get city => _city;
  ValidationItem get postcode => _postcode;
  ValidationItem get detailAddress => _detailAddress;

  String? get phoneNumber => _phoneNumber;
  set phoneNumber(value) => _phoneNumber = value;

  bool get isPhoneNumberValid => _isPhoneNumberValid;
  setIsPhoneNumberValid(value) {
    _isPhoneNumberValid = value;
    notifyListeners();
  }

  get defaultAddressToggled => _defaultAddressToggled;
  setDefaultAddressToggled(value) {
    _defaultAddressToggled = value;
    notifyListeners();
  }

  String getDefaultAddress() {
    if (defaultAddressToggled == true) {
      return 'Y';
    } else {
      return 'N';
    }
  }

  void setEditDefaultAddressToggled(String defaultAddress) {
    if (defaultAddress == 'Y') {
      setDefaultAddressToggled(true);
    } else {
      setDefaultAddressToggled(false);
    }
  }

  void setName(String name) {
    if (name.length >= 3) {
      _name = ValidationItem(name, null);
    } else {
      _name = ValidationItem(null, 'Must be at least 3 characters');
    }
    notifyListeners();
  }

  void setState(String state) {
    if (state.isNotEmpty) {
      _state = ValidationItem(state, null);
    } else {
      _state = ValidationItem(null, 'Please provide state');
    }
    notifyListeners();
  }

  void setCity(String city) {
    if (city.isNotEmpty) {
      _city = ValidationItem(city, null);
    } else {
      _city = ValidationItem(null, 'Please provide city');
    }
    notifyListeners();
  }

  void setPostcode(String postcode) {
    if (postcode.isNotEmpty) {
      _postcode = ValidationItem(postcode, null);
    } else {
      _postcode = ValidationItem(null, 'Please provide postal code');
    }
    notifyListeners();
  }

  void setDetailAddress(String detailAddress) {
    if (detailAddress.isNotEmpty) {
      _detailAddress = ValidationItem(detailAddress, null);
    } else {
      _detailAddress = ValidationItem(null, 'Please provide detail address');
    }
    notifyListeners();
  }

  bool isDetailsValid() {
    if (name.value != null &&
        state.value != null &&
        city.value != null &&
        postcode.value != null &&
        detailAddress.value != null &&
        isPhoneNumberValid) {
      return true;
    } else {
      return false;
    }
  }

  bool isDetailsChanged(
      {required Address editedAddress, required Address originalAddress}) {
    if (originalAddress.name != editedAddress.name ||
        originalAddress.phoneNumber != editedAddress.phoneNumber ||
        originalAddress.state != editedAddress.state ||
        originalAddress.city != editedAddress.city ||
        originalAddress.postcode != editedAddress.postcode ||
        originalAddress.addressLine1 != editedAddress.addressLine1 ||
        originalAddress.defaultAddress != editedAddress.defaultAddress) {
      return true;
    } else {
      return false;
    }
  }

  void setValidationItemEdit({required Address address}) {
    _name = ValidationItem(address.name, null);
    _state = ValidationItem(address.state, null);
    _city = ValidationItem(address.city, null);
    _postcode = ValidationItem(address.postcode, null);
    _detailAddress = ValidationItem(address.addressLine1, null);
    _phoneNumber = address.phoneNumber;
    setIsPhoneNumberValid(true);
    if (address.defaultAddress == 'Y') {
      setDefaultAddressToggled(true);
    } else {
      setDefaultAddressToggled(false);
    }
  }

  bool isDetailsEmpty() {
    if ((name.value == null || name.value == '') &&
        (state.value == null || state.value == '') &&
        (city.value == null || city.value == '') &&
        (postcode.value == null || postcode.value == '') &&
        (detailAddress.value == null || detailAddress.value == '') &&
        (phoneNumber == null || phoneNumber == '') &&
        (defaultAddressToggled == null || defaultAddressToggled == false)) {
      return true;
    } else {
      return false;
    }
  }

  Address getValidatedAddress(String userId) {
    final Address address = Address(
        userId: userId,
        name: name.value,
        phoneNumber: phoneNumber,
        state: state.value,
        city: city.value,
        postcode: postcode.value,
        addressLine1: detailAddress.value,
        defaultAddress: getDefaultAddress(),
        latitude: null,
        longitude: null);
    return address;
  }

  void resetValidationItem() {
    _name = ValidationItem(null, null);
    _state = ValidationItem(null, null);
    _city = ValidationItem(null, null);
    _postcode = ValidationItem(null, null);
    _detailAddress = ValidationItem(null, null);
    phoneNumber = null;
    setDefaultAddressToggled(false);
    setIsPhoneNumberValid(false);
  }
}
