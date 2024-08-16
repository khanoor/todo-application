import 'package:flutter/material.dart';
import 'package:todoapp/view/widgets/main_button.dart';

class FinalAlertBox extends StatelessWidget {
  final String title;

  const FinalAlertBox({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Image.asset('assets/todo.png',
          height: MediaQuery.sizeOf(context).height * 0.04),
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MainButton(
            title: 'Okay',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
