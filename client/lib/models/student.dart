class Student {
  int id;
  String email;
  DateTime birthDate;

  Student(this.id, this.email, this.birthDate);

  factory Student.fromMap(
    Map<String, dynamic> map,
  ) =>
      Student(
        map["id"],
        map["email"],
        map["dateNais"],
      );
}
