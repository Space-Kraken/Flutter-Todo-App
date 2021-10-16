import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/completed_taks_controller.dart';

class CompletedTaskListScreen extends StatelessWidget {
  const CompletedTaskListScreen({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GetBuilder<CompletedTaskController>(
        builder: (controller)=> controller.completedTasks.isEmpty?
        const Text('No Completed Tasks'):
        ListView.builder(
          itemCount: controller.completedTasks.length,
          itemBuilder: (context, index){
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(10),
              elevation: 3,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                    title: Center(child: Text(controller.completedTasks[index]!.title.toString())),
                    subtitle: Center(child: Column(
                      children: [
                        const SizedBox(height: 5,),
                        const Divider(
                          height: 5,
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                        ),
                        const SizedBox(height: 5,),
                        Text(controller.completedTasks[index]!.description.toString()),
                        const SizedBox(height: 5,),
                      ],
                    )),
                  ),
                  const Divider(
                    height: 5,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: (){
                          controller.unmarkTasl(controller.completedTasks[index]!.id!);
                        }, 
                        child: Row(
                          children: const [
                            Icon(Icons.unpublished_rounded, color: Colors.amber,),
                            Text("Unmark", style: TextStyle(color: Colors.amber),),
                          ],
                        ),),
                      TextButton(
                        onPressed: (){
                          controller.deleteTask(controller.completedTasks[index]!.id!);
                        }, 
                        child: Row(
                          children: const [
                            Icon(Icons.delete_rounded, color: Colors.red,),
                            Text("Delete", style: TextStyle(color: Colors.red),),
                          ],
                        ))
                    ],
                  )
                ],
              ),
            );
          }
        ),
      )
    );
  }
}