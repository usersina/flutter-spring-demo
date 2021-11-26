import 'dart:developer';

import 'package:client/models/student.dart';
import 'package:client/providers/student_provider.dart';
import 'package:client/services/http_student_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StudentDialog extends StatelessWidget {
  final Student? student;

  const StudentDialog({
    Key? key,
    this.student,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StudentProvider studentProvider =
        Provider.of<StudentProvider>(context, listen: false);

    final HttpStudentService _httpStudentService = HttpStudentService();
    final df = DateFormat('dd-MM-yyyy');
    DateTime selectedDate = DateTime.now();

    late bool isNew = student == null ? true : false;
    final firstNameController = TextEditingController(
      text: student == null ? '' : student!.firstName,
    );
    final lastNameController = TextEditingController(
      text: student == null ? '' : student!.lastName,
    );
    final dateTextController = TextEditingController(
      text: student == null ? '' : df.format(student!.birthDate),
    );

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1995),
        lastDate: DateTime(2050),
      );
      if (pickedDate != null && pickedDate != selectedDate) {
        dateTextController.text = df.format(pickedDate);
      }
    }

    handleAction() async {
      late Student myStudent;
      switch (isNew) {
        case true: // -- Create a new student
          if (firstNameController.text.isEmpty ||
              lastNameController.text.isEmpty ||
              dateTextController.text.isEmpty) {
            // Maybe show a toast or sth
            // Close the dialog without proceeding
            return Navigator.pop(context);
          }
          myStudent = await _httpStudentService.createStudent(
            Student(
              student!.id,
              firstNameController.text,
              lastNameController.text,
              df.parse(
                dateTextController.text,
              ),
            ),
          );
          break;
        case false: // -- Update an existing student
          myStudent = await _httpStudentService.updateStudent(
            Student(
              student!.id,
              firstNameController.text,
              lastNameController.text,
              df.parse(
                dateTextController.text,
              ),
            ),
          );
          break;
      }
      studentProvider.updateStudents(myStudent);
      // -- Close the dialog
      Navigator.pop(context);
    }

    return AlertDialog(
      title: Text(isNew ? 'Add a new student' : 'Edit student'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                hintText: "First name",
              ),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                hintText: "Last name",
              ),
            ),
            TextField(
              controller: dateTextController,
              readOnly: true,
              decoration: const InputDecoration(
                hintText: "Birthdate",
              ),
              onTap: () {
                _selectDate(context);
              },
            ),
            ElevatedButton(
              onPressed: handleAction,
              child: Text(isNew ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}
