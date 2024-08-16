import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/view/taskScreen/add_new_task.dart';
import 'package:todoapp/view_model.dart/task_view_model.dart';

void main() {
  testWidgets('AddNewTask widget displays correctly',
      (WidgetTester tester) async {
    // Provide a mock TaskProvider
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TaskProvider(),
        child: const MaterialApp(home: AddNewTask()),
      ),
    );

    // Verify that the AddNewTask dialog is shown
    expect(find.byType(AddNewTask), findsOneWidget);
    expect(find.text('Add new task'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byType(DropdownButtonFormField), findsOneWidget);
    expect(find.text('Create'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('Form validation and Create button functionality',
      (WidgetTester tester) async {
    // Provide a mock TaskProvider
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TaskProvider(),
        child: const MaterialApp(home: AddNewTask()),
      ),
    );

    // Tap the Create button without filling the form
    await tester.tap(find.text('Create'));
    await tester.pump();

    // Verify that form validation errors are shown
    expect(find.text('Title is required'), findsOneWidget);
    expect(find.text('Description is required'), findsOneWidget);
    expect(find.text('Due Date is required'), findsOneWidget);
    expect(find.text('Priority is required'), findsOneWidget);

    // Fill the form
    await tester.enterText(find.byType(TextFormField).at(0), 'Test Task');
    await tester.enterText(
        find.byType(TextFormField).at(1), 'Test Description');
    await tester.tap(find.byType(DropdownButtonFormField));
    await tester.pump();
    await tester.tap(find.text('Low').last);
    await tester.pump();
    await tester.tap(find.text('Create'));
    await tester.pump();

    // Check if Create button was tapped (this example does not check actual DB calls)
    // Implement appropriate mock or spy to verify method calls if needed
  });
}
