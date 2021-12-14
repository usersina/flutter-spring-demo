import 'dart:developer';

import 'package:client/models/classe.dart';
import 'package:client/models/student.dart';
import 'package:client/providers/classe_provider.dart';
import 'package:client/providers/student_provider.dart';
import 'package:client/screens/student/student_dialog.dart';
import 'package:client/screens/student/student_list.dart';
import 'package:client/services/http_classe_service.dart';
import 'package:client/services/http_student_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentScreen extends StatelessWidget {
  StudentScreen({Key? key}) : super(key: key);

  final HttpStudentService _httpStudentService = HttpStudentService();
  final HttpClasseService _httpClasseService = HttpClasseService();

  Widget futureDropdownMenu(BuildContext context) {
    ClasseProvider classeProvider =
        Provider.of<ClasseProvider>(context, listen: false);
    StudentProvider studentProvider =
        Provider.of<StudentProvider>(context, listen: false);

    return FutureBuilder<List<Classe>>(
      future: _httpClasseService.getAllClasses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          List<Classe> myClasses = snapshot.data!;
          myClasses.insert(0, ClasseProvider.placeholder);

          return DropdownButton<String>(
            isExpanded: true,
            value: classeProvider.selected?.name,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              if (newValue != null) {
                Classe selectedClasse = myClasses.firstWhere(
                  (element) => element.name == newValue,
                );
                classeProvider.setSelected(selectedClasse);
                studentProvider.filterStudents(newValue);
              }
              Navigator.pop(context);
            },
            items: myClasses.map<DropdownMenuItem<String>>(
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
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("${snapshot.error}"),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    StudentProvider studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    ClasseProvider classeProvider =
        Provider.of<ClasseProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Students"),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.menu),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    const Text(
                      "Selected classe:",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    futureDropdownMenu(context),
                  ],
                ),
              ),
            ],
          )
        ],
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
            log("Initializing students list, should not run on modal exit!");
            studentProvider.setStudents(snapshot.data ?? [], notify: false);
            if (classeProvider.selected?.name != null) {
              studentProvider.filterStudents(
                classeProvider.selected!.name,
                notify: false,
              );
            }
            return StudentList();
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const StudentDialog(),
          );
        },
      ),
    );
  }
}
