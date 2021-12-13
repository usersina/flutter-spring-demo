import 'package:client/models/classe.dart';

class Student {
  int? id;
  String firstName;
  String lastName;
  DateTime birthDate;
  Classe classe;

  Student(
    this.id,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.classe,
  );

  // Constructor used in form, since id should not be passed!
  Student.toForm(this.firstName, this.lastName, this.birthDate, this.classe);

  factory Student.fromJson(
    Map<String, dynamic> map,
  ) =>
      Student(
        map["id"],
        map["prenom"],
        map["nom"],
        DateTime.parse(map["dateNais"]),
        Classe.fromJson(map["classe"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "prenom": firstName,
        "nom": lastName,
        "dateNais": birthDate.toIso8601String(),
        "classe": classe.toJson(),
      };
}
