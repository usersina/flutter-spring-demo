class Student {
  int? id;
  String firstName;
  String lastName;
  DateTime birthDate;

  Student(
    this.id,
    this.firstName,
    this.lastName,
    this.birthDate,
  );

  factory Student.fromJson(
    Map<String, dynamic> map,
  ) =>
      Student(
        map["id"],
        map["prenom"],
        map["nom"],
        DateTime.parse(map["dateNais"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "prenom": firstName,
        "nom": lastName,
        "dateNais": birthDate.toIso8601String(),
      };
}
