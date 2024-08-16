import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String title;
  final String description;
  final String dueDate;
  final String priority;
  final Timestamp createdAt;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.createdAt,
  });

  factory Task.fromMap(Map<String, dynamic> data) {
    return Task(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      dueDate: data['dueDate'] ?? '',
      priority: data['priority'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'priority': priority,
      'createdAt': createdAt,
    };
  }
}
