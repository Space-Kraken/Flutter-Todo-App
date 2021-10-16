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
      // Initial Route for loader
      initialRoute: Routes.splashSCreen,
      // Routes definitions (optional)
      routes: {
        // Requested route => binding route
        Routes.splashSCreen: (context) => const SplashScreen(),
      },
      // Controller initializer 
      initialBinding: AppBinding(),
      // Banner hide
      debugShowCheckedModeBanner: false,
    );
  }
}
