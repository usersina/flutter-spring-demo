import 'package:client/models/classe.dart';
import 'package:client/providers/classe_provider.dart';
import 'package:client/services/http_classe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ClasseDialog extends StatelessWidget {
  final Classe? classe;

  const ClasseDialog({
    Key? key,
    this.classe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ClasseProvider classeProvider =
        Provider.of<ClasseProvider>(context, listen: false);

    final HttpClasseService _httpClasseService = HttpClasseService();
    late bool isNew = classe == null ? true : false;

    final nameController = TextEditingController(
      text: classe == null ? '' : classe!.name,
    );
    final capacityController = TextEditingController(
      text: classe == null ? '' : classe!.capacity.toString(),
    );

    handleAction() async {
      late Classe myClasse;
      switch (isNew) {
        case true: // -- Create a new classe
          if (nameController.text.isEmpty || capacityController.text.isEmpty) {
            // Maybe show a toast or sth
            // Close the dialog without proceeding
            return Navigator.pop(context);
          }
          myClasse = await _httpClasseService.createClasse(
            Classe.toForm(
              nameController.text,
              int.parse(capacityController.text),
            ),
          );
          classeProvider.addClasse(myClasse);
          break;
        case false: // -- Update an existing classe
          myClasse = await _httpClasseService.updateClasse(
            Classe(
              classe!.id,
              nameController.text,
              int.parse(capacityController.text),
            ),
          );
          classeProvider.updateClasses(myClasse);
          break;
      }

      // -- Close the dialog
      Navigator.pop(context);
    }

    return AlertDialog(
      title: Text(isNew ? 'Add a new classe' : 'Edit classe'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Classe name",
              ),
            ),
            TextField(
              controller: capacityController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: const InputDecoration(
                hintText: "Max capacity",
              ),
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
