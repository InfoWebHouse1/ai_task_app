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
    final response = await _taskRepo.geminiTextToGenApi(command);
    if (response == null) return;

    final action = response["action"];
    final title = response["title"];
    final description = response["description"];
    final datetimeStr = response["datetime"];
    final dateTime = DateTime.tryParse(datetimeStr ?? '');

    if (action == "create" && dateTime != null) {
      final data = TaskModel(taskTitle: title, taskDescription: description, taskDate: dateTime);
      final box = Boxes.getTaskData();
      box.add(data);
      data.save();
    } else if (action == "update" && dateTime != null) {
      taskModel.taskTitle = title;
      taskModel.taskDescription = description;
      taskModel.taskDate = dateTime;
      taskModel.save();
    } else if (action == "delete" && taskModel.taskTitle == title) {
      taskModel.delete();
    }
    notifyListeners();
  }
}
