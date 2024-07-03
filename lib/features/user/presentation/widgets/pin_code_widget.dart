import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

import '../../../app/theme/style.dart';

class PinCodeWidget extends StatelessWidget {
  final TextEditingController otpController;
  final Function(String) onComplete;

  const PinCodeWidget({
    super.key,
    required this.otpController,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          PinCodeFields(
            controller: otpController,
            length: 6,
            activeBorderColor: tabColor,
            textStyle: const TextStyle(color: textColor),
            onComplete: onComplete,
          ),
          const Text("Enter your 6 digit code"),
        ],
      ),
    );
  }
}
