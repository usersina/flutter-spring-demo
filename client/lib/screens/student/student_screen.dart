import 'dart:developer';

import 'package:client/models/student.dart';
import 'package:client/services/http_student_service.dart';
import 'package:flutter/material.dart';

class StudentScreen extends StatelessWidget {
  StudentScreen({Key? key}) : super(key: key);

  final HttpStudentService _httpStudentService = HttpStudentService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Students"),
      ),
      body: FutureBuilder(
        future: _httpStudentService.getAllStudents(),
        builder: (context, AsyncSnapshot<List<Student>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return Text("${snapshot.data}");
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
