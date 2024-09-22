import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png', // এখানে আপনার ছবির লোকেশন দিন
              height: 30, // ছবির উচ্চতা
              width: 30, // ছবির প্রস্থ
            ),
            SizedBox(width: 10), // ছবি এবং টেক্সটের মাঝে কিছু স্পেস
            Text('Live Tender BD'),
          ],
        ),
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
          // মূল কন্টেন্ট
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Download our app from the Play Store',
                        style: TextStyle(
                          fontSize: 32,
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
                        child: Text('Go to Play Store',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              // যোগাযোগের তথ্য একেবারে নিচে দেখাবে
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 20), // নিচের কিছু প্যাডিং যোগ করা হয়েছে
                child: Column(
                  children: [
                    Text(
                      'For any queries, contact us:',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Phone: 0191-4448971',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      'Email: support@livetenderbd.com',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
