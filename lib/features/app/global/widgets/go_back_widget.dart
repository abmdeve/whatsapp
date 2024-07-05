import 'package:flutter/material.dart';
import 'package:whatsapp/features/app/theme/style.dart';

class GoBackWidget extends StatelessWidget {
  const GoBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back,
        color: textColor,
        size: 30,
      ),
    );
  }
}
