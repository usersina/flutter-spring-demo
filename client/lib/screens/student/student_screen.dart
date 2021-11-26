import 'dart:developer';

import 'package:client/models/student.dart';
import 'package:client/providers/student_provider.dart';
import 'package:client/screens/student/student_list.dart';
import 'package:client/services/http_student_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentScreen extends StatelessWidget {
  StudentScreen({Key? key}) : super(key: key);

  final HttpStudentService _httpStudentService = HttpStudentService();

  @override
  Widget build(BuildContext context) {
    StudentProvider studentProvider =
        Provider.of<StudentProvider>(context, listen: false);

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
            // -- Initalize provider data
            log("Initializing students list!");
            studentProvider.setStudents(snapshot.data ?? [], notify: false);
            return StudentList(students: studentProvider.list);
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
