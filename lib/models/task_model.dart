import 'package:hive_ce_flutter/adapters.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String taskName;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final bool isHighPriority;
  @HiveField(4)
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

  Map<String, dynamic> toJson() {
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
    return 'TaskModel{id: $id,'
        ' taskName: $taskName,'
        ' description: $description,'
        ' isHighPriority: $isHighPriority,'
        ' isDone: $isDone}';
  }
}
