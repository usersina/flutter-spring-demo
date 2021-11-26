import 'package:client/models/student.dart';
import 'package:client/screens/student/student_dialog.dart';
import 'package:client/services/http_student_service.dart';
import 'package:flutter/material.dart';

class StudentList extends StatelessWidget {
  final HttpStudentService _httpStudentService = HttpStudentService();
  final List<Student> students;

  StudentList({Key? key, required this.students}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (BuildContext context, int index) {
        Student student = students[index];
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) async {
            await _httpStudentService.deleteStudent(student.id!);
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
