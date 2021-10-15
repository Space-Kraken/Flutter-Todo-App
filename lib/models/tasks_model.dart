class TaskModel {
  int? id;
  String? title;
  String? description;
  DateTime? deadline;
  bool? status;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.deadline,
    this.status,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      deadline: DateTime.parse(map['deadline']),
      status: map['status'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'deadline': deadline?.toIso8601String(),
      'status': status == true ? 1 : 0,
    };
  }
}
