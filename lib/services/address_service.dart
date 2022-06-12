import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/address.dart';
import 'package:sainee_detailing/services/response_model.dart';
import 'package:sainee_detailing/services/rest.dart';

class AddressService {
  final restService = service<Rest>();

  Future<List<Address>?> getAllAddress() async {
    final json = await restService.get('addresses') as List?;
    if (json == null) {
      return null;
    }
    List<Address>? addresses =
        json.map((address) => Address.fromJson(address)).toList();
    return addresses;
  }

  Future<List<Address>?> getUserAddress(String userId) async {
    final json = await restService.get('addresses/user/$userId') as List?;
    if (json == null) {
      return null;
    }
    List<Address>? addresses =
        json.map((address) => Address.fromJson(address)).toList();
    return addresses;
  }

  Future<List<Address>?> createNewAddress(Address address) async {
    final json =
        await restService.postWithToken('addresses', data: address) as List?;

    if (json == null) {
      return null;
    }
    List<Address>? addresses =
        json.map((address) => Address.fromJson(address)).toList();
    return addresses;
  }

  Future<Address?> updateAddress(
      {required String addressId, required Address editedAddress}) async {
    final json = await restService.putWithToken('addresses/$addressId',
        data: editedAddress);

    if (json == null) {
      return null;
    }

    Address? address = Address.fromJson(json);
    return address;
  }

  Future<String?> deleteAddress(String addressId) async {
    final json = await restService.deleteWithToken('addresses/$addressId');

    if (json == null) {
      return null;
    }

    final Response result = Response.fromJson(json);
    if (result.status == '1') {
      return result.message;
    }
    return null;
  }
}
