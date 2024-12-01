import 'package:flutter/material.dart';

class DepartmentProvider with ChangeNotifier {
  List<String> _departments = ['LGED', 'PWD', 'RHD'];

  List<String> get departments => _departments;

  void addDepartment(String department) {
    if (!_departments.contains(department)) {
      _departments.add(department);
      notifyListeners();
    }
  }
}
