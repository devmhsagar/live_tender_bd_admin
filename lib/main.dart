import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_tender_bd_admin/admin/auth/login_screen.dart';
import 'package:live_tender_bd_admin/admin/screen/dashboard_screen.dart';
import 'package:live_tender_bd_admin/admin/service/department_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDP7V4EBVabIZnlt3hrN3R0o06j2s9IzlU",
      projectId: "livetenderbdadmin",
      messagingSenderId: "928307222734",
      appId: "1:928307222734:web:2a42bcee8f1ac25240589f",
    ),
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({required this.isLoggedIn, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DepartmentProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: isLoggedIn ? '/dashboard' : '/',
        getPages: [
          GetPage(name: '/', page: () => LoginPage()),
          GetPage(name: '/dashboard', page: () => DashboardPage()),
        ],
      ),
    );
  }
}
