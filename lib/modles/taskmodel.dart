class TaskModel {
  final int id;
  final String taskName;
  final String description;
  final bool isHighPriority;
  bool isDone;

  TaskModel({
    required this.id,
    required this.taskName,
    required this.description,
    required this.isHighPriority,
    this.isDone = false,
  });

  factory TaskModel.fromJSON(Map<String, dynamic> json) {
    return TaskModel(
      id: json["id"],
      taskName: json["taskName"],
      description: json["description"],
      isHighPriority: json["isHighPriority"],
      isDone: json["isDone"] ?? false,
    );
  }

  Map<String, dynamic> toJeson() {
    return {
      "id": id,
      "taskName": taskName,
      "description": description,
      "isHighPriority": isHighPriority,
      "isDone": isDone,
    };
  }

  @override
  String toString() {
    return 'TaskModel{id: $id, taskName: $taskName, description: $description, isHighPriority: $isHighPriority, isDone: $isDone}';
  }
}
