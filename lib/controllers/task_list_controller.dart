import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/completed_taks_controller.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/models/tasks_model.dart';
import 'package:todo_app/screens/completed_task_list_screen.dart';

class TaskListController extends GetxController {
  List<TaskModel?> taskList = <TaskModel>[];
  
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var taskTitleField = TextEditingController();
  var taskDescField = TextEditingController();
  var taskDeadLineField = TextEditingController();
  var selectedDate = DateTime.now().obs;

  void resetForm(){
    formKey.currentState!.reset();
    taskTitleField.text = "";
    taskDescField.text = "";
    selectedDate.value = DateTime.now();
  }

  void changeDate(DateTime date){
    selectedDate.value = date;
  }

  void getTasks() async {
    var database = DatabaseHelper();
    database.getTaskList(completed: false).then((tasks) {
      taskList = tasks;
      update();
    });
  }

   void insertTask(String title, String description, DateTime date) {
    var database = DatabaseHelper();
    TaskModel newTask = TaskModel(
      title: title, 
      description: description,
      deadline: date,
      status: false,
    );
    database.insert(newTask.toMap());
    getTasks();
  }

  void deleteTask(int id){
    var database = DatabaseHelper();
    database.delete(id);
    getTasks();
  }

  void completeTask(int taskId){
    final completController = Get.find<CompletedTaskController>();
    var database = DatabaseHelper();
    database.changeState(taskId: taskId, completed: true);
    getTasks();
    completController.getTasks();
  }

  void updateTask(int taskId, String title, String description, DateTime date){
    var database = DatabaseHelper();
    TaskModel updateTask = TaskModel(
      id: taskId,
      title: title,
      description: description,
      deadline: date,
      status: false, 
    );
    database.update(updateTask.toMap());
    getTasks();
  }
}
