import 'dart:convert';

import 'package:client/models/user.dart';
import 'package:http/http.dart';

class HttpAuthService {
  final String baseUrl = "http://10.0.2.2:8080/";

  Future<User> registerWithEmailAndPassword(
      String email, String password) async {
    final response = await post(
      Uri.parse(baseUrl + "register"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {'email': email, 'password': password},
      ),
    );

    if (response.statusCode == 200) {
      return User.fromMap(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to register.');
    }
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final response = await post(
      Uri.parse(baseUrl + "login"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {'email': email, 'password': password},
      ),
    );

    if (response.statusCode == 200) {
      return User.fromMap(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to register.');
    }
  }
}
