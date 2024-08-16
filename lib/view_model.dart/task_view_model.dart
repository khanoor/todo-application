import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/resources/utils.dart';

class TaskProvider with ChangeNotifier {
  String _dueDate = '';
  String _priority = 'Low';
  bool _isCompleted = false;
  bool get isCompleted => _isCompleted;

  String get dueDate => _dueDate;
  String get priority => _priority;

  void setDueDate(DateTime date) {
    _dueDate = "${date.day}/${date.month}/${date.year}";
    notifyListeners();
  }

  void setPriority(String priority) {
    _priority = priority;
    notifyListeners();
  }

  void setCompleted(bool completed) {
    _isCompleted = completed;
    notifyListeners();
  }

  Future<void> addTask(
      String title, String description, BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('tasks').add({
        'title': title,
        'description': description,
        'dueDate': _dueDate,
        'priority': _priority,
        'isCompleted': isCompleted,
        'createdAt': FieldValue.serverTimestamp(),
      });
      Utils.toastMessage("Task added");
    } catch (e) {
      Utils.flushbarErrorMessage("failed to create task", context);
      if (kDebugMode) {
        print('Error adding task: $e');
      }
      rethrow;
    }
  }
}
