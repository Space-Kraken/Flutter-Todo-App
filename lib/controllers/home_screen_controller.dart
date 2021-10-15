import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var taskTitleField = TextEditingController();
  var taskDescField = TextEditingController();
  var taskDeadLineField = TextEditingController();
  var selectedDate = DateTime.now().obs;
  var tab = 0.obs;

  changeTab(int index) {
    tab.value = index;
  }

  void resetForm(){
    formKey.currentState!.reset();
    taskTitleField.text = "";
    taskDescField.text = "";
    selectedDate.value = DateTime.now();
  }

  void changeDate(DateTime date){
    selectedDate.value = date;
  }
}
