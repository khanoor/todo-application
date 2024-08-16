import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/resources/app_pallete.dart';
import 'package:todoapp/view/taskScreen/view_task.dart';
import 'package:todoapp/view/widgets/alert_box.dart';

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({super.key});

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _deleteTask(String taskId) async {
    try {
      await _firestore.collection('tasks').doc(taskId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete task: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No tasks available'));
          }

          final tasks = snapshot.data!.docs;

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final taskId = task.id;
              final title = task['title'] ?? 'No Title';
              final isCompleted = task['isCompleted'] ?? 'false';
              final dueDate = task['dueDate'] ?? 'No Due Date';
              final priority = task['priority'] ?? 'low';

              Color priorityColor;

              switch (priority) {
                case 'Medium':
                  priorityColor = Colors.orange;
                  break;
                case 'High':
                  priorityColor = Colors.red;
                  break;
                default:
                  priorityColor = Colors.grey;
                  break;
              }

              return tasks.isEmpty
                  ? const Center(child: Text('No tasks available'))
                  : Container(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewTaskScreen(
                                      task: task.data() as Map<String, dynamic>,
                                      taskId: taskId,
                                    )),
                          );
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isCompleted == true
                                ? Colors.green
                                : priorityColor,
                            child: Text(
                              (index + 1).toString(),
                              style:
                                  const TextStyle(color: AppPallete.whiteColor),
                            ),
                          ),
                          title: Text(title),
                          subtitle: Text('Due Date: $dueDate'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertBox(
                                    title: 'Delete task',
                                    onYesPressed: () {
                                      _deleteTask(taskId);
                                      Navigator.pop(context);
                                    },
                                    subTitle:
                                        'Are you sure you want to delete?',
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
            },
          );
        },
      ),
    );
  }
}
