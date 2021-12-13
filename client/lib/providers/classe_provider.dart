import 'package:client/models/classe.dart';
import 'package:flutter/foundation.dart';

class ClasseProvider extends ChangeNotifier {
  List<Classe> list = [];

  //--------------------Methods---------------------//
  void setClasses(List<Classe> newList, {bool notify = true}) {
    list = newList;
    if (notify) notifyListeners();
  }

  void updateClasses(Classe classe) {
    list[list.indexWhere((element) => element.id == classe.id)] = classe;
    notifyListeners();
  }

  void addClasse(Classe classe) {
    list.add(classe);
    notifyListeners();
  }

  void deleteClasse(int id) {
    list.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
