import 'dart:convert';
import 'dart:developer';

import 'package:client/models/classe.dart';
import 'package:http/http.dart';

class HttpClasseService {
  final String baseUrl = "http://10.0.2.2:8080/classes";

  Future<Classe> createClasse(Classe student) async {
    final response = await post(
      Uri.parse(baseUrl),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(student.toJson()),
    );

    if (response.statusCode == 200) {
      return Classe.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception("Could not create classe");
    }
  }

  Future<Classe> updateClasse(Classe student) async {
    final response = await put(
      Uri.parse(baseUrl),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(student.toJson()),
    );

    if (response.statusCode == 200) {
      return Classe.fromJson(
        jsonDecode(response.body),
      );
    } else {
      log(response.request.toString());
      log(response.body);
      throw Exception("Could not create classe");
    }
  }

  Future<List<Classe>> getAllClasses() async {
    final response = await get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List rawResult = jsonDecode(response.body);
      return rawResult
          .map(
            (rawClasse) => Classe.fromJson(rawClasse),
          )
          .toList();
    } else {
      throw Exception('Failed to fetch students');
    }
  }

  Future deleteClasse(int id) async {
    final response = await delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to delete the classe');
    }
  }
}
