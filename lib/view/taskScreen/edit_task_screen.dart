import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/resources/app_pallete.dart';
import 'package:todoapp/resources/utils.dart';
import 'package:todoapp/view/widgets/main_button.dart';

class EditTaskScreen extends StatefulWidget {
  final String taskId;
  final Map<String, dynamic> task;

  const EditTaskScreen({
    super.key,
    required this.taskId,
    required this.task,
  });

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _dueDateController;
  late String _priority;
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task['title']);
    _descriptionController =
        TextEditingController(text: widget.task['description']);
    _dueDateController = TextEditingController(text: widget.task['dueDate']);
    _priority = widget.task['priority'] ?? 'low';
    _isCompleted = widget.task['isCompleted'] ?? false;
  }

  Future<void> _updateTask() async {
    try {
      await _firestore.collection('tasks').doc(widget.taskId).update({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'dueDate': _dueDateController.text,
        'priority': _priority,
        'isCompleted': _isCompleted,
      });
      Utils.snackBar('Task updated successfully', context, Colors.green);

      Navigator.pop(context);
    } catch (e) {
      Utils.snackBar('Failed to update task: $e', context, Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppPallete.whiteColor),
        title: const Text(
          'Edit Task',
          style: TextStyle(color: AppPallete.whiteColor),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppPallete.gradient1, AppPallete.gradient2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dueDateController,
              decoration: const InputDecoration(
                labelText: 'Due Date',
                hintText: 'e.g., 30/04/2024',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _priority,
              decoration: const InputDecoration(labelText: 'Priority'),
              items: const [
                DropdownMenuItem(
                  value: 'low',
                  child: Text('Low'),
                ),
                DropdownMenuItem(
                  value: 'Medium',
                  child: Text('Medium'),
                ),
                DropdownMenuItem(
                  value: 'High',
                  child: Text('High'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _priority = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Completed:'),
                Checkbox(
                  value: _isCompleted,
                  onChanged: (value) {
                    setState(() {
                      _isCompleted = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            MainButton(
                title: "Save Changes",
                onPressed: () {
                  _updateTask();
                })
          ],
        ),
      ),
    );
  }
}
