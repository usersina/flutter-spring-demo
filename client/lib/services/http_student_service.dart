import 'dart:convert';
import 'dart:developer';

import 'package:client/models/student.dart';
import 'package:http/http.dart';

class HttpStudentService {
  final String baseUrl = "http://10.0.2.2:8080/etudiants";

  // -- TESTME:
  Future<Student> createStudent(Student student) async {
    final response = await post(
      Uri.parse(baseUrl),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(student.toJson()),
    );

    if (response.statusCode == 200) {
      return Student.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception("Could not create student");
    }
  }

  Future<Student> updateStudent(Student student) async {
    final response = await put(
      Uri.parse(baseUrl),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(student.toJson()),
    );

    if (response.statusCode == 200) {
      return Student.fromJson(
        jsonDecode(response.body),
      );
    } else {
      log(response.request.toString());
      log(response.body);
      throw Exception("Could not create student");
    }
  }

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

  Future deleteStudent(int id) async {
    final response = await delete(Uri.parse("$baseUrl/$id"));
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to delete the student');
    }
  }
}
