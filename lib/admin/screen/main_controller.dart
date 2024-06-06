import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:live_tender_bd_admin/admin/auth/login_screen.dart';
import 'package:live_tender_bd_admin/admin/screen/add_department_screen.dart';
import 'package:live_tender_bd_admin/admin/screen/add_location_screen.dart';
import 'package:live_tender_bd_admin/admin/screen/add_method_screen.dart';
import 'package:live_tender_bd_admin/admin/screen/all_tender_screen.dart';
import 'package:live_tender_bd_admin/admin/screen/tender_input_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController {
  Widget currentPage = const Center(
      child: Text('Welcome to the Dashboard',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));

  @override
  void onInit() {
    super.onInit();
    _checkLoginState();
  }

  void _checkLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!isLoggedIn) {
      Get.offAll(() => LoginPage());
    }
  }

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
        _logout();
        break;
      default:
        currentPage = const Center(
            child: Text('Page Not Found',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
        break;
    }
    update();
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Get.offAll(() => LoginPage());
  }
}
