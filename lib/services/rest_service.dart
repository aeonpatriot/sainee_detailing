import 'dart:convert';

import 'package:sainee_detailing/services/rest.dart';
import 'package:http/http.dart' as http;

class RestService implements Rest {
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  @override
  Future post(String endpoint, {dynamic data}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
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