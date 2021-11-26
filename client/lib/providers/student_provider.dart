import 'package:client/models/student.dart';
import 'package:flutter/foundation.dart';

class StudentProvider extends ChangeNotifier {
  List<Student> list = [];

  //--------------------Methods---------------------//
  void setStudents(List<Student> newList) {
    list = newList;
    notifyListeners();
  }

  void clearStudents() {
    list = [];
    notifyListeners();
  }
}
