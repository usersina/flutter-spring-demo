import 'package:client/models/student.dart';
import 'package:flutter/foundation.dart';

class StudentProvider extends ChangeNotifier {
  List<Student> list = [];

  //--------------------Methods---------------------//
  void setStudents(List<Student> newList, {bool notify = true}) {
    list = newList;
    if (notify) notifyListeners();
  }

  void updateStudents(Student student) {
    list[list.indexWhere((element) => element.id == student.id)] = student;
    notifyListeners();
  }

  void clearStudents() {
    list = [];
    notifyListeners();
  }
}
