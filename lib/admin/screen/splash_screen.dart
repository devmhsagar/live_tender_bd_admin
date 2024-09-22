import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // সুন্দর স্পিনার ইফেক্ট এর জন্য স্পিনকিট ব্যবহার করা হয়েছে
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    simulateLoading();
  }

  // এই ফাংশনটি লোডিংয়ের সময় প্রোগ্রেস আপডেট করে
  void simulateLoading() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        progressValue += 0.2; // প্রতি 500ms এ ২০% প্রগতি হবে
      });

      if (progressValue < 1.0) {
        simulateLoading(); // 100% এর আগে আবার কল হবে
      } else {
        Get.offNamed('/'); // 100% হলে হোম পেজে পাঠাবে
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // সুন্দর ডিজাইনের কাস্টম স্পিনার ইফেক্ট (Spinkit)
            SpinKitFadingCircle(
              color: Colors.blueAccent,
              size: 100.0,
            ),
            SizedBox(height: 20),
            // প্রগতি দেখানোর জন্য একটি চমৎকার CircularProgressIndicator
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: CircularProgressIndicator(
                    value:
                        progressValue, // এখানে পার্সেন্টেজ অনুযায়ী প্রোগ্রেস দেখাবে
                    strokeWidth: 10.0,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  ),
                ),
                Text(
                  '${(progressValue * 100).round()}%', // শতাংশ আকারে দেখাবে
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Loading...',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
