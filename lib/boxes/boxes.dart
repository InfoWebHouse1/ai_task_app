import 'package:hive/hive.dart';
import 'package:task_app_ai/model/task_model.dart';

class Boxes {
  static Box<TaskModel> getTaskData() => Hive.box<TaskModel>("tasks");
}
