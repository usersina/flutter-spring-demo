import 'package:client/models/student.dart';
import 'package:flutter/foundation.dart';

class StudentProvider extends ChangeNotifier {
  List<Student> initialList = [];
  List<Student> list = [];

  //--------------------Methods---------------------//
  void setStudents(List<Student> newList, {bool notify = true}) {
    initialList = newList;
    list = newList;
    if (notify) notifyListeners();
  }

  void updateStudents(Student student) {
    list[list.indexWhere((element) => element.id == student.id)] = student;
    notifyListeners();
  }

  void filterStudents(String classname, {bool notify = true}) {
    if (classname == "All") {
      list = initialList;
    } else {
      list = initialList
          .where((element) => element.classe.name == classname)
          .toList();
    }
    if (notify) notifyListeners();
  }

  void addStudent(Student student) {
    list.add(student);
    notifyListeners();
  }

  void deleteStudent(int id) {
    list.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
