import 'package:sainee_detailing/dependencies.dart';
import 'package:sainee_detailing/models/user.dart';
import 'package:sainee_detailing/services/rest.dart';
import 'package:sainee_detailing/services/rest_service.dart';

class UserService {
  final restService = service<Rest>();

  Future<User?> createNewUser(User user) async {
    final json = await restService.post('register', data: user);
    print(json);
    print(json['user']);
    if (json == null) return null;

    return User.fromJson(json['user']);
  }
}
