import 'package:flutter/material.dart';
import 'package:todoapp/resources/app_pallete.dart';
import 'package:todoapp/view/taskScreen/edit_task_screen.dart';

class ViewTaskScreen extends StatelessWidget {
  final String taskId;
  final Map<String, dynamic> task;

  const ViewTaskScreen({
    super.key,
    required this.taskId,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final title = task['title'] ?? 'No Title';
    final description = task['description'] ?? 'No Description';
    final dueDate = task['dueDate'] ?? 'No Due Date';
    final isCompleted = task['isCompleted'] ?? false;
    final priority = task['priority'] ?? 'low';

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppPallete.whiteColor),
        title: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: AppPallete.whiteColor),
        ),
        backgroundColor:
            isCompleted ? Colors.green : _getPriorityColor(priority),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: AppPallete.whiteColor,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskScreen(
                    taskId: taskId,
                    task: task,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTaskDetailRow(
                  icon: Icons.description,
                  label: 'Description',
                  content: description,
                ),
                const SizedBox(height: 16),
                _buildTaskDetailRow(
                  icon: Icons.calendar_today,
                  label: 'Due Date',
                  content: dueDate,
                ),
                const SizedBox(height: 16),
                _buildTaskDetailRow(
                  icon: Icons.flag,
                  label: 'Priority',
                  content: priority,
                  contentColor: _getPriorityColor(priority),
                ),
                const SizedBox(height: 16),
                _buildTaskDetailRow(
                  icon: isCompleted ? Icons.check_circle : Icons.circle,
                  label: 'Completed',
                  content: isCompleted ? 'Yes' : 'No',
                  contentColor: isCompleted ? Colors.green : Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskDetailRow({
    required IconData icon,
    required String label,
    required String content,
    Color? contentColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.blueGrey,
          size: 28,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: TextStyle(
                  fontSize: 16,
                  color: contentColor ?? Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Medium':
        return Colors.orange;
      case 'High':
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }
}
