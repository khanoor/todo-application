import 'package:flutter/material.dart';
import 'package:todoapp/resources/app_pallete.dart';

class MainButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool loading;

  const MainButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          decoration: BoxDecoration(
            color: AppPallete.gradient1,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          height: 50,
          width: double.infinity,
          child: loading
              ? const CircularProgressIndicator()
              : Text(
                  title,
                  style: const TextStyle(
                    color: AppPallete.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                )),
    );
  }
}
