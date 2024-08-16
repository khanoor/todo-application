import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/view/taskScreen/view_task.dart';

void main() {
  testWidgets('ViewTaskScreen displays task details',
      (WidgetTester tester) async {
    // Arrange
    final task = {
      'title': 'Test Task',
      'description': 'Test Description',
      'dueDate': '2024-08-30',
      'priority': 'High',
      'isCompleted': false,
    };

    await tester.pumpWidget(
      MaterialApp(
        home: ViewTaskScreen(
          taskId: 'test-task-id',
          task: task,
        ),
      ),
    );

    // Act & Assert
    expect(find.text('Test Task'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
    expect(find.text('Due Date: 2024-08-30'), findsOneWidget);
    expect(find.text('Priority: High'), findsOneWidget);
    expect(find.text('Completed: No'), findsOneWidget);

    // Check if the edit button is present
    expect(find.byIcon(Icons.edit), findsOneWidget);
  });
}
