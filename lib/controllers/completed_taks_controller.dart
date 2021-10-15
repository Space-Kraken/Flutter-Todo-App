import 'package:get/get.dart';
import 'package:todo_app/controllers/task_list_controller.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/models/tasks_model.dart';

class CompletedTaskController extends GetxController {
  List<TaskModel?> completedTasks = <TaskModel>[];

  void getTasks() async{
    var database = DatabaseHelper();
    database.getTaskList(completed: true).then((value) {
      completedTasks = value;
      update();
    });
  }

  void deleteTask(int taskId) async{
    var database = DatabaseHelper();
    database.delete(taskId);
    getTasks();
  }

  void unmarkTasl(int taskId) async {
    final taskController = Get.find<TaskListController>();
    var database = DatabaseHelper();
    database.changeState(taskId: taskId, completed: false);
    getTasks();
    taskController.getTasks();
  }   
}