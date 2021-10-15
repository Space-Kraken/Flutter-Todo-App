import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:todo_app/controllers/completed_taks_controller.dart';
import 'package:todo_app/controllers/task_list_controller.dart';
import 'package:todo_app/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskController = Get.find<TaskListController>();
      taskController.getTasks();
    
    final completedTaskController = Get.find<CompletedTaskController>();
      completedTaskController.getTasks();
    return SplashScreenView(
      navigateRoute: const HomeScreen(),
      duration: 5000,
      text: "AntyLazy App",
      backgroundColor: Colors.white,
      textType: TextType.TyperAnimatedText,
      textStyle: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
