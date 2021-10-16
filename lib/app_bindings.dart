import 'package:get/get.dart';
import 'package:todo_app/controllers/completed_taks_controller.dart';
import 'package:todo_app/controllers/home_screen_controller.dart';
import 'package:todo_app/controllers/task_list_controller.dart';

// Clase especial de Get
class AppBinding implements Bindings {
  // Constructor
  @override
  void dependencies() {
    // Inicializacion de todos los controladores
    Get.put<HomeScreenController>(HomeScreenController());
    Get.put<TaskListController>(TaskListController());
    Get.put<CompletedTaskController>(CompletedTaskController());
  }
}
