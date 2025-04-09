import 'package:artistic__mode/screens/calligraphy_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Artistic Mode',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/canvas', page: () => CalligraphyPage2()),
      ],
    );
  }
}
