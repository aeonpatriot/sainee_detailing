import 'package:image_picker/image_picker.dart';
import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/user.dart';
import 'package:sainee_detailing/services/rest.dart';

class UserService {
  final restService = service<Rest>();

  Future<User?> createNewUser(User user) async {
    final json = await restService.post('register', data: user);
    print(json);
    print(json['user']);
    if (json == null) return null;

    return User.fromJson(json['user']);
  }

  Future<User?> login(User user) async {
    final json = await restService.post('login', data: user);
    if (json == null) return null;
    restService.apiToken = json['token'];

    print('token:  ' + restService.apiToken);
    return User.fromJson(json['user']);
  }

  Future<User?> updateProfileDetails(User user) async {
    final json = await restService.putWithToken('user/${user.id}', data: user);
    // print('user service');
    // print(json);
    if (json == null) return null;
    print('user service update succss');
    return User.fromJson(json);
  }

  Future<User?> updateImage(
      {required String userId,
      required XFile? imageFile,
      required String imageType}) async {
    final String endpoint;
    final String requestName;
    if (imageType == 'headerImage') {
      endpoint = 'user/headerImage/$userId';
      requestName = 'headerImage';
    } else {
      requestName = 'profileImage';
      endpoint = 'user/profileImage/$userId';
    }
    // else if (imageType == 'profileImage') {
    //   endpoint = 'user/profileImage/$userId';
    // }

    final json = await restService.uploadImage(
        endpoint, imageFile, imageType, requestName);

    if (json == null) return null;
    print('from user service');
    print(json);
    return User.fromJson(json['data']);
  }

  Future<bool> logout() async {
    final json = await restService.postWithToken('logout');
    if (json == null) return false;

    return true;
  }
}
