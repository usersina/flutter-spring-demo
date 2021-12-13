import 'package:client/models/classe.dart';
import 'package:flutter/foundation.dart';

class ClasseProvider extends ChangeNotifier {
  List<Classe> list = [];

  static Classe placeholder = Classe(-1, "All", -1);
  Classe? selected = placeholder;

  //--------------------Methods---------------------//
  // -- Classes list
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

  // -- Selected classe
  void setSelected(Classe classe) {
    selected = classe;
    notifyListeners();
  }
}
