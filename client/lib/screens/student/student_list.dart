import 'package:client/models/student.dart';
import 'package:client/providers/classe_provider.dart';
import 'package:client/providers/student_provider.dart';
import 'package:client/screens/student/student_dialog.dart';
import 'package:client/services/http_student_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentList extends StatelessWidget {
  final HttpStudentService _httpStudentService = HttpStudentService();

  StudentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // -- Only listen for changes in this widget as not to fetch data again
    StudentProvider studentProvider = Provider.of<StudentProvider>(
      context,
      listen: true,
    );

    return ListView.builder(
      itemCount: studentProvider.list.length,
      itemBuilder: (BuildContext context, int index) {
        Student student = studentProvider.list[index];
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) async {
            await _httpStudentService.deleteStudent(student.id!);
            studentProvider.deleteStudent(student.id!);
          },
          child: ListTile(
            title: Text(
              '${student.firstName} ${student.lastName}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('Birthday:  ${student.birthDate}'),
            onTap: () {},
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => StudentDialog(
                    student: student,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
