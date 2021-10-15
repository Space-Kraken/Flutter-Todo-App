import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/task_list_controller.dart';

class TaskListScreen extends StatelessWidget {
  final controller = Get.find<TaskListController>();

  @override
  Widget build(BuildContext context) {

    return Center(
      child:  GetBuilder<TaskListController>(
        builder:(controller) => controller.taskList.isEmpty ? 
        const Text('No tasks yet!'):
        ListView.builder(
          itemCount: controller.taskList.length,
          itemBuilder: (context, index){
            var timeLimitStatus = 0;

            if(controller.taskList[index]!.deadline!.isAfter(DateTime.now())){
              timeLimitStatus = 1;
            }else{
              if (controller.taskList[index]!.deadline!.difference(DateTime.now()) > const Duration(days: -1)) {
                timeLimitStatus = 2;
              } else {
                timeLimitStatus = 3;
              }
            }
            return OpenContainer(
              openElevation: 0,
              closedElevation: 0,
              closedColor: Colors.transparent,
              transitionType: ContainerTransitionType.fadeThrough,
              openBuilder: (BuildContext context, VoidCallback _){
                controller.changeDate(controller.taskList[index]!.deadline!);
                return SizedBox(
                  height: 240,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Card(
                      color: Colors.white,
                      child: Form(
                        key: controller.formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                child: Text('Edit Task',style: TextStyle(fontSize: 20)),
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
                                  hintText: controller.taskList[index]!.title!,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  labelText: 'Task title',
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                  hintText: controller.taskList[index]!.description!,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  labelText: 'Task description',
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
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
                                  Obx(()=>Text(controller.selectedDate.toString().substring(0, 10))),
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
                                    controller.updateTask(
                                      controller.taskList[index]!.id!,
                                      controller.taskTitleField.text == "" ? controller.taskList[index]!.title!: controller.taskTitleField.text,
                                      controller.taskDescField.text == "" ? controller.taskList[index]!.description!: controller.taskDescField.text,
                                      controller.selectedDate.value,
                                    );
                                    controller.resetForm();
                                    Navigator.pop(context);
                                }, 
                                child: const Text("Save")
                              )
                            ]
                          ),
                        ) 
                      ),
                    )
                  ),
                );
              },
              closedBuilder: (BuildContext context, VoidCallback openContainer){
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.only(bottom: 5,left: 10, right: 10, top: 10),
                  elevation: 3,
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                        title: Center(
                          child: Text(controller.taskList[index]!.title.toString())
                        ),
                        subtitle: Center(
                          child:Column(
                            children: [
                              const Divider(
                                height: 5,
                                thickness: 1,
                                indent: 20,
                                endIndent: 20,
                              ),
                              const SizedBox(height: 15),
                              Text(controller.taskList[index]!.description.toString()),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(children: [
                                    timeLimitStatus == 1 ? 
                                      const Icon(Icons.calendar_today_rounded, color: Colors.green, size: 20,) : 
                                      timeLimitStatus == 2 ? 
                                        const Icon(Icons.timelapse_rounded, color: Colors.orange, size: 20,) : 
                                        const Icon(Icons.timer_off_rounded, color: Colors.red, size: 20,),
                                    Text("Due to: ", style: TextStyle(fontSize: 12, color: timeLimitStatus == 1 ? Colors.green : timeLimitStatus == 2 ? Colors.amber : Colors.red)),
                                  ],),
                                  Text(controller.taskList[index]!.deadline.toString().substring(0,10), 
                                  style: TextStyle(fontSize: 12, color: timeLimitStatus == 1 ? Colors.green : timeLimitStatus == 2 ? Colors.amber : Colors.red)),
                                ]
                              ),
                            ],
                          )
                        ),
                      ),
                      const Divider(
                        height: 5,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        TextButton(onPressed: ()=>{
                        controller.completeTask(controller.taskList[index]!.id!),
                        }, 
                        child: const Text("Finish")),
                        TextButton(onPressed: ()=>{
                          controller.deleteTask(controller.taskList[index]!.id!),
                        }, child: const Text("Delete")),
                      ],)
                    ],
                  ),
                );
              } , 
            );
          } 
        ) 
      )
    );
  }
}

Future<void> _selectDate(BuildContext context, TaskListController controller) async{
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
