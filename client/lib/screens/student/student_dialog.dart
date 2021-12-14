import 'package:client/models/classe.dart';
import 'package:client/models/student.dart';
import 'package:client/providers/classe_provider.dart';
import 'package:client/providers/student_provider.dart';
import 'package:client/services/http_classe_service.dart';
import 'package:client/services/http_student_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StudentDialog extends StatefulWidget {
  final Student? student;

  const StudentDialog({
    Key? key,
    this.student,
  }) : super(key: key);

  @override
  State<StudentDialog> createState() => _StudentDialogState();
}

class _StudentDialogState extends State<StudentDialog> {
  final HttpClasseService _httpClasseService = HttpClasseService();

  Classe? _selectedClasse;
  List<Classe>? classes;

  @override
  initState() {
    super.initState();
    _selectedClasse = widget.student?.classe;
    fetchClasses();
  }

  fetchClasses() async {
    classes = await _httpClasseService.getAllClasses();
  }

  @override
  Widget build(BuildContext context) {
    StudentProvider studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    ClasseProvider classeProvider =
        Provider.of<ClasseProvider>(context, listen: false);

    final HttpStudentService _httpStudentService = HttpStudentService();
    final df = DateFormat('dd-MM-yyyy');
    DateTime selectedDate = DateTime.now();

    late bool isNew = widget.student == null ? true : false;
    final firstNameController = TextEditingController(
      text: widget.student == null ? '' : widget.student!.firstName,
    );
    final lastNameController = TextEditingController(
      text: widget.student == null ? '' : widget.student!.lastName,
    );
    final dateTextController = TextEditingController(
      text: widget.student == null ? '' : df.format(widget.student!.birthDate),
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
      Classe? selectedClasse = classeProvider.selected;
      if (selectedClasse?.name == "All") {
        selectedClasse = null;
      }
      switch (isNew) {
        case true: // -- Create a new student
          if (firstNameController.text.isEmpty ||
              lastNameController.text.isEmpty ||
              dateTextController.text.isEmpty) {
            // Maybe show a toast or sth
            // Close the dialog without proceeding
            return Navigator.pop(context);
          }
          // Find the appropriate classe based on its name

          myStudent = await _httpStudentService.createStudent(
            Student.toForm(
              firstNameController.text,
              lastNameController.text,
              df.parse(
                dateTextController.text,
              ),
              selectedClasse,
            ),
          );
          studentProvider.addStudent(myStudent);
          if (selectedClasse != null) {
            studentProvider.filterStudents(selectedClasse.name);
          }
          break;
        case false: // -- Update an existing student
          myStudent = await _httpStudentService.updateStudent(
            Student(
              widget.student!.id,
              firstNameController.text,
              lastNameController.text,
              df.parse(
                dateTextController.text,
              ),
              selectedClasse,
            ),
          );
          studentProvider.updateStudents(myStudent);
          if (selectedClasse != null) {
            studentProvider.filterStudents(selectedClasse.name);
          }
          break;
      }

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
            classes == null
                ? const Text("Loading...")
                : DropdownButtonFormField<String>(
                    value: _selectedClasse?.name,
                    isExpanded: true,
                    items: classes!.map<DropdownMenuItem<String>>(
                      (Classe classe) {
                        return DropdownMenuItem<String>(
                          value: classe.name,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.meeting_room,
                                color: Colors.black,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                classe.name,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        // _selectedClasse = value;
                        // classeProvider.setSelected(selectedClasse);
                        // studentProvider.filterStudents(newValue);
                      });
                    },
                  ),
            const SizedBox(height: 5),
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
