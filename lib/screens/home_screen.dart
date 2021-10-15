import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/home_screen_controller.dart';
import 'package:todo_app/controllers/task_list_controller.dart';
import 'package:todo_app/screens/completed_task_list_screen.dart';
import 'package:todo_app/screens/task_list_screen.dart';

class HomeScreen extends StatelessWidget {
  
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeScreenController>();
    
    final _tabScreens = <Widget>[
      TaskListScreen(),
      const CompletedTaskListScreen()
    ];

    final _bottomNavigationBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
          icon: Icon(Icons.assignment_rounded), label: 'Todo'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.assignment_turned_in_rounded), label: 'Completed'),
    ];

    assert(_tabScreens.length == _bottomNavigationBarItems.length);

    return Obx(() => Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('My ToDo List')),
          ),
          body: _tabScreens[controller.tab.value],
          bottomNavigationBar: BottomNavigationBar(
            items: _bottomNavigationBarItems,
            currentIndex: controller.tab.value,
            type: BottomNavigationBarType.fixed,
            onTap: (index) => controller.changeTab(index),
          ),
          floatingActionButton: controller.tab.value == 0
              ? FloatingActionButton(
                  onPressed: () => {
                    showModalBottomSheet(
                      context: context, 
                      enableDrag: true,
                      isDismissible: true,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      builder: (ctx) => _buildBottomSheet(ctx, controller)
                    ).whenComplete(() => controller.resetForm())
                      
                  },
                  child: const Icon(Icons.add),
                )
              : null,
        ));
  }
}

Widget _buildBottomSheet(BuildContext context, HomeScreenController controller) {
  final taskListController = Get.find<TaskListController>();

  return Card(
    color: Colors.white,
    child: SizedBox(
      height: MediaQuery.of(context).size.height / 2 +
          MediaQuery.of(context).viewInsets.bottom,
          child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Add Task',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ), 
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: controller.taskTitleField,
                  maxLength: 25,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Task title',
                    contentPadding: const EdgeInsets.all(10.0),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please enter a task title';
                    }
                  }
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: controller.taskDescField,
                  maxLength: 180,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Task description',
                    contentPadding: const EdgeInsets.all(10.0),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please enter a task title';
                    }
                  }
                ),
                const Divider(
                  height: 20,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(()=>Text(controller.selectedDate.value.toString().substring(0,10))),
                    InkWell(
                      onTap: ()=> _selectDate(context, controller),
                      child: const Icon(Icons.calendar_today),
                    ),
                  ],
                ),
                 const Divider(
                  height: 25,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: (){
                    if(controller.formKey.currentState!.validate()){
                      taskListController.insertTask(
                        controller.taskTitleField.text,
                        controller.taskDescField.text,
                        controller.selectedDate.value,
                      );
                      Navigator.pop(context);
                    }
                  }, 
                  child: const Text("Save")
                )
              ],
            ),
          )
        )
    ),
  );
}

Future<void> _selectDate(BuildContext context, HomeScreenController controller) async{
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: controller.selectedDate.value,
    firstDate: DateTime(2020),
    lastDate: DateTime(2050)
  );
  if (pickedDate != null && pickedDate != controller.selectedDate.value) {
    controller.changeDate(pickedDate); 
  }
}
