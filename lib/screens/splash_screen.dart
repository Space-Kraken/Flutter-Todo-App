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
    // Obtencion del controlador
    final taskController = Get.find<TaskListController>();
    // Consulta de preparacion de datos
      taskController.getTasks();
    
    // Obtencion del controlador
    final completedTaskController = Get.find<CompletedTaskController>();
    // Consulta de preparacion de datos
      completedTaskController.getTasks();

    return SplashScreenView(
      // Ruta (widget/screen) siguiente
      navigateRoute: const HomeScreen(),
      // Delay de cambio de ruta
      duration: 5000,
      // Titulo de la app
      text: "Organizer",
      // Logo de la app 
      imageSrc: 'assets/logo.png',
      // Tamaño del logo de la app 
      imageSize: 150,
      // Tipo de transcicion del widget
      pageRouteTransition: PageRouteTransition.SlideTransition,
      // Color de fondo
      backgroundColor: Colors.white,
      // Estilo de animacion del texto
      textType: TextType.NormalText,
      // Estilos 
      textStyle: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
