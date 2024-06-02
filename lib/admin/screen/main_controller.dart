import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:live_tender_bd_admin/admin/screen/add_department_screen.dart';
import 'package:live_tender_bd_admin/admin/screen/add_location_screen.dart';
import 'package:live_tender_bd_admin/admin/screen/add_method_screen.dart';
import 'package:live_tender_bd_admin/admin/screen/all_tender_screen.dart';
import 'package:live_tender_bd_admin/admin/screen/tender_input_screen.dart';

class MainController extends GetxController {
  Widget currentPage = const Center(
      child: Text('Welcome to the Dashboard',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));

  void navigateTo(String route) {
    switch (route) {
      case '/all-tender':
        currentPage = AllTenderPage();
        break;
      case '/tender-input':
        currentPage = const TenderInputPage();
        break;
      case '/add-tender-method':
        currentPage = AddTenderMethodPage();
        break;
      case '/add-location':
        currentPage = AddLocationPage();
        break;
      case '/add-department':
        currentPage = InsertDepartmentForm();
        break;
      case '/logout':
        // Handle logout
        break;
      default:
        currentPage = const Center(
            child: Text('Page Not Found',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
        break;
    }
    update();
  }
}
