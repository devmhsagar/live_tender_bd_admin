import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_tender_bd_admin/admin/auth/login_screen.dart';
import 'package:live_tender_bd_admin/admin/screen/dashboard_screen.dart';
import 'package:live_tender_bd_admin/admin/screen/home_screen.dart';
import 'package:live_tender_bd_admin/admin/screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash', // প্রথমে স্প্ল্যাশ স্ক্রিন দেখাবে
      getPages: [
        GetPage(
            name: '/splash', page: () => SplashScreen()), // স্প্ল্যাশ স্ক্রিন
        GetPage(name: '/', page: () => HomePage()), // হোম পেজ
        GetPage(name: '/login', page: () => LoginPage()), // লগইন পেজ
        GetPage(
            name: '/dashboard',
            page: () => DashboardWrapper()), // লগইন করলে ড্যাশবোর্ড
      ],
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
          return Center(child: CircularProgressIndicator()); // লোডিং ইন্ডিকেটর
        }

        // চেক করা হচ্ছে লগইন স্টেট
        final isLoggedIn = snapshot.data?.getBool('isLoggedIn') ?? false;
        if (isLoggedIn) {
          return DashboardPage(); // যদি লগইন করা থাকে, ড্যাশবোর্ডে যাবে
        } else {
          return LoginPage(); // লগইন না করলে লগইন পেজে নিয়ে যাবে
        }
      },
    );
  }
}
