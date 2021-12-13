import 'dart:developer';

import 'package:client/models/classe.dart';
import 'package:client/providers/classe_provider.dart';
import 'package:client/screens/classe/classe_dialog.dart';
import 'package:client/services/http_classe_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClasseList extends StatelessWidget {
  final HttpClasseService _httpClasseService = HttpClasseService();

  ClasseList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // -- Only listen for changes in this widget as not to fetch data again
    ClasseProvider classeProvider = Provider.of<ClasseProvider>(
      context,
      listen: true,
    );

    return ListView.builder(
      itemCount: classeProvider.list.length,
      itemBuilder: (BuildContext context, int index) {
        Classe classe = classeProvider.list[index];
        return Dismissible(
          key: UniqueKey(),
          confirmDismiss: (direction) async {
            log("Show confirmation dialog, on confirm delete & return true");
            // await _httpClasseService.deleteClasse(classe.id!);
            // classeProvider.deleteClasse(classe.id!);
            return false;
          },
          child: ListTile(
            title: Text(
              classe.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('Max capacity: ${classe.capacity}'),
            onTap: () {},
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ClasseDialog(
                    classe: classe,
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
