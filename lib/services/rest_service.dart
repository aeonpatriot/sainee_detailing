import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:sainee_detailing/services/rest.dart';
import 'package:http/http.dart' as http;

class RestService implements Rest {
  String? _apiToken;
  // static const String _baseUrl = 'http://10.0.2.2:8000/api';
  // static const String _baseUrl = 'http://192.168.1.107:8080/api';
  static const String _baseUrl = 'http://192.168.1.106:8080/api';

  @override
  set apiToken(value) => _apiToken = value;
  @override
  get apiToken => _apiToken;

  @override
  Future get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // print(response.body);
      return jsonDecode(response.body);
    }

    return null;
  }

  @override
  Future getWithToken(String endpoint) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $_apiToken'
      },
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  }

  @override
  Future post(String endpoint, {dynamic data}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // print(response.statusCode);
      // print(response.body);
      return jsonDecode(response.body);
    }

    return null;
  }

  //POST with token METHOD
  @override
  Future postWithToken(String endpoint, {dynamic data}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $_apiToken'
      },
      // body: data,
      body: jsonEncode(data),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // print(response.statusCode);

      return jsonDecode(response.body);
    }

    // print(response.statusCode);
    return null;
  }

  //PUT with token METHOD
  @override
  Future putWithToken(String endpoint, {dynamic data}) async {
    // print('$_baseUrl/$endpoint');
    // print(data.toString());
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint?_method=PUT'),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $_apiToken'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // print(response.body);
      // print(response.statusCode);
      return jsonDecode(response.body);
    }
    // print(response.statusCode);
    return null;
  }

//DELETE with token METHOD
  @override
  Future deleteWithToken(String endpoint) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $_apiToken'
      },
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // print(response.statusCode);
      return jsonDecode(response.body);
    }

    // print(response.statusCode);
    // print(response.body);
    return null;
  }

  @override
  Future uploadImage(
      {required String endpoint,
      XFile? imageFile,
      required String requestName}) async {
    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse('$_baseUrl/$endpoint'));

    request.headers
        .addAll(<String, String>{'Authorization': 'Bearer $_apiToken'});

    File pickedFile = File(imageFile!.path);

    request.files.add(http.MultipartFile(requestName,
        pickedFile.readAsBytes().asStream(), pickedFile.lengthSync(),
        filename: pickedFile.path.split("/").last));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print(response.statusCode);
      return jsonDecode(await response.stream.bytesToString());
    } else {
      // print(response.contentLength);
      // print(response.statusCode);
      return null;
    }
  }
}
