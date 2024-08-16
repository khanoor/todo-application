import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/view/taskScreen/priority_task.dart';

void main() {
  testWidgets('PriorityTask widget displays correctly',
      (WidgetTester tester) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Add a test task to Firestore
    await firestore.collection('tasks').add({
      'title': 'Test Task',
      'description': 'Test Description',
      'dueDate': '24/8/2024',
      'isCompleted': false,
      'priority': 'High',
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PriorityTask(),
        ),
      ),
    );

    // Verify that the PriorityTask widget is shown
    expect(find.byType(PriorityTask), findsOneWidget);
    expect(find.text('Test Task'), findsOneWidget);
    expect(find.text('Due Date: 24/8/2024'), findsOneWidget);
  });

  testWidgets('PriorityTask widget filters completed tasks',
      (WidgetTester tester) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Add test tasks to Firestore
    await firestore.collection('tasks').add({
      'title': 'Completed Task',
      'description': 'This task is completed',
      'dueDate': '24/8/2024',
      'isCompleted': true,
      'priority': 'High',
    });

    await firestore.collection('tasks').add({
      'title': 'Incomplete Task',
      'description': 'This task is not completed',
      'dueDate': '24/8/2024',
      'isCompleted': false,
      'priority': 'Medium',
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PriorityTask(),
        ),
      ),
    );

    // Verify that only incomplete tasks are shown
    expect(find.text('Incomplete Task'), findsOneWidget);
    expect(find.text('Completed Task'), findsNothing);
  });
}
