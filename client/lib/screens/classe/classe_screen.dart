import 'package:client/models/classe.dart';
import 'package:client/providers/classe_provider.dart';
import 'package:client/screens/classe/classe_dialog.dart';
import 'package:client/screens/classe/classe_list.dart';
import 'package:client/screens/student/student_dialog.dart';
import 'package:client/services/http_classe_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClasseScreen extends StatelessWidget {
  ClasseScreen({Key? key}) : super(key: key);

  final HttpClasseService _httpStudentService = HttpClasseService();

  @override
  Widget build(BuildContext context) {
    ClasseProvider classeProvider =
        Provider.of<ClasseProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Classes"),
      ),
      body: FutureBuilder<List<Classe>>(
        future: _httpStudentService.getAllClasses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            classeProvider.setClasses(snapshot.data ?? [], notify: false);
            return ClasseList();
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
            builder: (context) => const ClasseDialog(),
          );
        },
      ),
    );
  }
}
