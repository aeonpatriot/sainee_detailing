import 'package:image_picker/image_picker.dart';

abstract class Rest {
  String? _apiToken;
  set apiToken(value);
  get apiToken;
  Future get(String endpoint);
  Future post(String endpoint, {dynamic data});
  Future postWithToken(String endpoint, {dynamic data});
  Future putWithToken(String endpoint, {dynamic data});
  Future deleteWithToken(String endpoint);
  Future uploadImage(
      String endpoint, XFile? imageFile, String imageType, String requestName);
}
