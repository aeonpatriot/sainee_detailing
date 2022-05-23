import 'dart:convert';
import 'dart:io';

import 'package:sainee_detailing/services/rest.dart';
import 'package:http/http.dart' as http;

class RestService implements Rest {
  String? _apiToken;
  static const String _baseUrl = 'http://10.0.2.2:8000/api';

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
      return jsonDecode(response.body);
    }

    return null;
  }

  // GET all and return a list
  // @override
  // Future getAll(String endpoint) async {
  //   final response = await http.get(
  //     Uri.parse('$_baseUrl/$endpoint'),
  //     headers: {'Content-Type': 'application/json'},
  //   );
  //   print('$_baseUrl/$endpoint');

  //   if (response.statusCode == 200) {
  //     print('inside 200');
  //     return jsonDecode(response.body);
  //   }

  //   print('outside 200');
  //   return null;
  // }

  @override
  Future post(String endpoint, {dynamic data}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.statusCode);
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
      body: jsonEncode(data),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.statusCode);
      return jsonDecode(response.body);
    }

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
      print(response.statusCode);
      return jsonDecode(response.body);
    }
    print(response.statusCode);
    return null;
  }
}
