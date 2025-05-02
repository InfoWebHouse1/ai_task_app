import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String? taskTitle;
  @HiveField(1)
  String? taskDescription;
  @HiveField(2)
  DateTime? taskDate;

  TaskModel({this.taskTitle, this.taskDate, this.taskDescription});

  //   TaskModel.fromJson(Map<String, dynamic> json) {
  //     id = json['id'];
  //     taskTitle = json['taskName'];
  //     taskDate = json['taskDate'];
  //     taskDescription = json['taskDescription'];
  //   }

  //   Map<String, dynamic> toJson() {
  //     final Map<String, dynamic> data = <String, dynamic>{};
  //     data['id'] = id;
  //     data['taskName'] = taskTitle;
  //     data['taskDate'] = taskDate;
  //     data['taskDescription'] = taskDescription;
  //     return data;
  //   }
}
