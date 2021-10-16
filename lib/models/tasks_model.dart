class TaskModel { //Clase modelo
  int? id;            //
  String? title;      //Parametros
  String? description;//del modelo
  DateTime? deadline; //
  bool? status;       //

  TaskModel({ //Cosntructor
    this.id,          //
    this.title,       //
    this.description, //Mapeo de los 
    this.deadline,    //parametros
    this.status,      //
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    // Metodo para crear un modelo apartir de datos
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      deadline: DateTime.parse(map['deadline']),
      status: map['status'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toMap() {
    // Metodo para crear datos apartir de un modelo
    return {
      'id': id,
      'title': title,
      'description': description,
      'deadline': deadline?.toIso8601String(),
      'status': status == true ? 1 : 0,
    };
  }
}
