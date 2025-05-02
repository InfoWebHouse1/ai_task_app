import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_app_ai/boxes/boxes.dart';
import 'package:task_app_ai/model/task_model.dart';
import 'package:task_app_ai/view_model/task_view_model.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskViewModel>(context, listen: false).initSpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI Task Generator")),
      body: ValueListenableBuilder<Box<TaskModel>>(
        valueListenable: Boxes.getTaskData().listenable(),
        builder: (context, box, _) {
          final data = box.values.toList().cast<TaskModel>();
          debugPrint("TASK COUNT: ${data.length}");
          for (var t in data) {
            debugPrint("Title: ${t.taskTitle}, Description: ${t.taskDescription}, Date: ${t.taskDate}");
          }

          if (data.isEmpty) {
            return const Center(child: Text("No tasks found."));
          }

          return ListView.builder(
            shrinkWrap: true,
            reverse: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data[index].taskTitle ?? "No Title", style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.primary)),
                        Text(data[index].taskDescription ?? "No Description", style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.secondary)),
                        Text(
                          DateFormat('yyyy-MM-dd – kk:mm').format(data[index].taskDate!),
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.onSurface.withAlpha(200)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer<TaskViewModel>(
        builder: (context, consumer, child) {
          return FloatingActionButton(onPressed: consumer.isListening ? null : consumer.listeningCommand, child: Icon(consumer.isListening ? Icons.mic_off : Icons.mic));
        },
      ),
    );
  }
}
