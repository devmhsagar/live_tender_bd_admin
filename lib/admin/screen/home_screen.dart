import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple, // AppBar এর ব্যাকগ্রাউন্ড কালার
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png', // আপনার লোগো ইমেজ লোকেশন দিন
              height: 30, // লোগোর উচ্চতা
              width: 30, // লোগোর প্রস্থ
            ),
            const SizedBox(width: 10),
            const Text(
              'Live Tender BD',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
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
            child: const Text(
              'Admin Login',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Container(
        // গ্রেডিয়েন্ট ব্যাকগ্রাউন্ড
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.deepPurpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png', // আপনার লোগোর পথ দিন
                      height: 80, // লোগোর উচ্চতা
                      width: 80, // লোগোর প্রস্থ
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Live Tender BD',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Download our app from the link below',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.white, // বাটনের ব্যাকগ্রাউন্ড কালার
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12), // বাটনের প্যাডিং
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // বাটনের কোণ গোলাকার
                        ),
                      ),
                      onPressed: () async {
                        const url =
                            'https://play.google.com/store/apps/details?id=com.livetenderbd.new_live_tender_bd'; // সঠিক ডাউনলোড লিংক দিন
                        final uri = Uri.parse(url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri,
                              mode: LaunchMode.externalApplication);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: const Text(
                        'Download App',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.deepPurple, // বাটনের টেক্সট কালার
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Text(
                    'For any queries, contact us:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Phone: 01914-448971',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70, // হালকা সাদা রঙ
                    ),
                  ),
                  Text(
                    'Email: support@livetenderbd.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70, // হালকা সাদা রঙ
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
