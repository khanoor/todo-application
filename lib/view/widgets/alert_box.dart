import 'package:flutter/material.dart';
import 'package:todoapp/view/widgets/main_button.dart';

class AlertBox extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onYesPressed;

  const AlertBox({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onYesPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: Text(subTitle, textAlign: TextAlign.center),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: MainButton(
                  title: 'No',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: MainButton(
                  title: 'Yes',
                  onPressed: onYesPressed,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
