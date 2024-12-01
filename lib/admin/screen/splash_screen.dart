import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  void simulateLoading() async {
    for (int i = 1; i <= 5; i++) {
      await Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          progressValue = i * 0.2;
        });
      });
    }
    Get.offNamed('/'); // 100% হলে নেক্সট স্ক্রিনে
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitFadingCircle(
              color: Colors.blueAccent,
              size: 100.0,
            ),
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: CircularProgressIndicator(
                    value: progressValue,
                    strokeWidth: 8.0,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  ),
                ),
                Text(
                  '${(progressValue * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Loading, please wait...',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
