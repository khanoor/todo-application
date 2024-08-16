import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/resources/utils.dart';
import 'package:todoapp/view/widgets/main_button.dart';
import 'package:todoapp/view_model.dart/task_view_model.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Image.asset(
        'assets/todo.png',
        height: 36,
      ),
      content: SizedBox(
        width: 300,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Add new task",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Consumer<TaskProvider>(
                  builder: (context, taskProvider, child) {
                    return TextFormField(
                      controller:
                          TextEditingController(text: taskProvider.dueDate),
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Due Date',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Due Date is required';
                        }
                        return null;
                      },
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          Provider.of<TaskProvider>(context, listen: false)
                              .setDueDate(pickedDate);
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
                Consumer<TaskProvider>(
                  builder: (context, taskProvider, child) {
                    return DropdownButtonFormField<String>(
                      value: taskProvider.priority,
                      decoration: const InputDecoration(
                        labelText: 'Priority',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Low',
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
                        if (value != null) {
                          Provider.of<TaskProvider>(context, listen: false)
                              .setPriority(value);
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Priority is required';
                        }
                        return null;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: MainButton(
                  title: 'Cancel',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: MainButton(
                  title: 'Create',
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      String title = _titleController.text;
                      String description = _descriptionController.text;

                      TaskProvider taskProvider =
                          Provider.of<TaskProvider>(context, listen: false);

                      try {
                        await taskProvider.addTask(title, description, context);
                        Navigator.of(context).pop();
                      } catch (e) {
                        Utils.toastMessage(e.toString());
                        if (kDebugMode) {
                          print('Error creating task: $e');
                        }
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
