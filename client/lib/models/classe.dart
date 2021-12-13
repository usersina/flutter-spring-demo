class Classe {
  int? id;
  String name;
  int capacity;

  Classe(this.id, this.name, this.capacity);

  // Constructor used in form, since id should not be passed!
  Classe.toForm(this.name, this.capacity);

  factory Classe.fromJson(
    Map<String, dynamic> map,
  ) =>
      Classe(
        map["id"],
        map["nom"],
        map["nbEtudiant"],
      );

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "nom": name,
        "nbEtudiant": capacity,
      };
}
