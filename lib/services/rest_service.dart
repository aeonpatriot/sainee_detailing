import 'dart:convert';
import 'dart:io';

import 'package:sainee_detailing/services/rest.dart';
import 'package:http/http.dart' as http;

class RestService implements Rest {
  String? _apiToken;
  static const String _baseUrl = 'http://10.0.2.2:8000/api';

  set apiToken(value) => _apiToken = value;
  get apiToken => _apiToken;

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

  @override
  Future get(String endpoint) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  }
}
