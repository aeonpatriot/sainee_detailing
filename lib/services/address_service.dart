import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/address.dart';
import 'package:sainee_detailing/services/rest.dart';

class AddressService {
  final restservice = service<Rest>();

  Future<List<Address>?> getAllAddress() async {
    final json = await restservice.get('addresses') as List?;
    if (json == null) {
      return null;
    }
    List<Address>? addresses =
        json.map((address) => Address.fromJson(address)).toList();
    return addresses;
  }

  Future<List<Address>?> getUserAddress(String userId) async {
    final json = await restservice.get('addresses/user/$userId') as List?;
    if (json == null) {
      return null;
    }
    List<Address>? addresses =
        json.map((address) => Address.fromJson(address)).toList();
    return addresses;
  }

  Future<Address?> createNewAddress(Address address) async {
    final json = await restservice.postWithToken('addresses', data: address);

    print(json);
    if (json == null) return null;

    return Address.fromJson(json);
  }
}
