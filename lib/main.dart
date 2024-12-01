import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_tender_bd_admin/admin/auth/login_screen.dart';
import 'package:live_tender_bd_admin/admin/screen/dashboard_screen.dart';
import 'package:live_tender_bd_admin/admin/screen/home_screen.dart';
import 'package:live_tender_bd_admin/admin/screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyDP7V4EBVabIZnlt3hrN3R0o06j2s9IzlU",
          projectId: "livetenderbdadmin",
          messagingSenderId: "928307222734",
          appId: "1:928307222734:web:2a42bcee8f1ac25240589f",
        ),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
          );
        } else if (snapshot.hasError) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Error initializing Firebase')),
            ),
          );
        }
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/splash',
          getPages: [
            GetPage(name: '/splash', page: () => SplashScreen()),
            GetPage(name: '/', page: () => HomePage()),
            GetPage(name: '/login', page: () => LoginPage()),
            GetPage(name: '/dashboard', page: () => DashboardWrapper()),
          ],
        );
      },
    );
  }
}

class DashboardWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Error loading preferences')),
          );
        }

        final isLoggedIn = snapshot.data?.getBool('isLoggedIn') ?? false;
        return isLoggedIn ? DashboardPage() : LoginPage();
      },
    );
  }
}
