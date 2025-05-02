import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:task_app_ai/boxes/boxes.dart';
import 'package:task_app_ai/model/task_model.dart';
import 'package:task_app_ai/repository/task_repo.dart';

class TaskViewModel extends ChangeNotifier {
  final _taskRepo = TaskRepository();
  final _speechToText = SpeechToText();
  TaskModel taskModel = TaskModel();
  bool _isListening = false;

  bool get isListening => _isListening;
  String lastWord = "";

  Future initSpeechToText() async {
    await _speechToText.initialize();
    notifyListeners();
  }

  disposeSpeech() {
    _speechToText.stop();
  }

  setIsListening(bool value) {
    _isListening = value;
    notifyListeners();
  }

  Future<void> listeningCommand() async {
    bool available = await _speechToText.initialize();
    if (available) {
      setIsListening(true);
      _speechToText.listen(
        onResult: (result) async {
          if (result.finalResult) {
            setIsListening(false);
            _speechToText.stop();
            await _handleVoiceCommand(result.recognizedWords);
          }
        },
      );
    }
  }

  Future<void> _handleVoiceCommand(String command) async {
    debugPrint("Voice Command Received: $command");
    final response = await _taskRepo.geminiTextToGenApi(command);
    if (response == null) return;

    final action = response["action"]?.toLowerCase();
    final title = response["title"];
    final description = response["description"];
    final datetimeStr = response["datetime"];
    final dateTime = DateTime.tryParse(datetimeStr ?? '');

    final box = Boxes.getTaskData();

    switch (action) {
      case "create":
        if (title != null && dateTime != null) {
          final newTask = TaskModel(taskTitle: title, taskDescription: description ?? '', taskDate: dateTime);
          box.add(newTask);
          newTask.save();
        }
        break;

      case "update":
        final existingTask = box.values.firstWhere((task) => task.taskTitle?.toLowerCase() == title?.toLowerCase(), orElse: () => TaskModel());

        if (existingTask.taskTitle != null && dateTime != null) {
          existingTask.taskTitle = title;
          existingTask.taskDescription = description ?? '';
          existingTask.taskDate = dateTime;
          existingTask.save();
        }
        break;

      case "delete":
        final taskToDelete = box.values.firstWhere((task) => task.taskTitle?.toLowerCase() == title?.toLowerCase(), orElse: () => TaskModel());

        if (taskToDelete.taskTitle != null) {
          taskToDelete.delete();
        }
        break;

      default:
        debugPrint("Unrecognized action: $action");
    }

    notifyListeners();
  }
}
