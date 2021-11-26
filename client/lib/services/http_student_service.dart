import 'dart:convert';

import 'package:client/models/student.dart';
import 'package:http/http.dart';

class HttpStudentService {
  final String baseUrl = "http://10.0.2.2:8080/etudiants";

  // -- TESTME:
  Future<Student> createStudent(Student student) async {
    final response = await post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: student.toJson(),
    );

    if (response.statusCode == 201) {
      return Student.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception("Could not create student");
    }
  }

  // -- TESTME:
  Future<List<Student>> getAllStudents() async {
    final response = await get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List rawResult = jsonDecode(response.body);
      return rawResult
          .map(
            (rawStudent) => Student.fromJson(rawStudent),
          )
          .toList();
    } else {
      throw Exception('Failed to fetch students');
    }
  }
}
