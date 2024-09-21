import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Live Tender BD'),
        actions: [
          TextButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

              if (isLoggedIn) {
                Get.toNamed('/dashboard'); // লগইন থাকলে ড্যাশবোর্ডে নিয়ে যাবে
              } else {
                Get.toNamed('/login'); // না থাকলে লগইন পেজে নিয়ে যাবে
              }
            },
            child: Text(
              'Admin Login',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          // ব্যাকগ্রাউন্ড ইমেজ
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/bg.jpg'), // ইমেজ লোকেশন সঠিক কিনা নিশ্চিত করুন
                fit: BoxFit.cover, // পুরো স্ক্রিনে ইমেজ ফিট হবে
              ),
            ),
          ),
          // মূল ,কন্টেন্ট
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Download our app from the Play Store',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors
                        .white, // টেক্সটের কালার যাতে ইমেজের সাথে মানিয়ে যায়
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    const url =
                        'https://play.google.com/store/apps/details?id=com.livetenderbd.live_tender_bd'; // আপনার অ্যাপের লিংক
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Text('Go to Play Store'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
