import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'calligraphy_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.off(() => const CalligraphyPage2()); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(28, 27, 27, 1),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            'assets/images/splash_screen2.png', 
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
