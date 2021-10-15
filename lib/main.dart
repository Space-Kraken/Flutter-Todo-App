import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app_bindings.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.splashSCreen,
      routes: {
        Routes.splashSCreen: (context) => const SplashScreen(),
      },
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
