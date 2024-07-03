import 'package:flutter/material.dart';

import '../../../app/theme/style.dart';

class PhoneNumber extends StatelessWidget {
  final TextEditingController phoneController;
  final String phoneCode;

  const PhoneNumber({
    super.key,
    required this.phoneController,
    required this.phoneCode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.50,
                color: tabColor,
              ),
            ),
          ),
          width: 80,
          height: 42,
          alignment: Alignment.center,
          child: Text(
            phoneCode,
            style: const TextStyle(color: greyColor),
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Container(
            height: 40,
            margin: const EdgeInsets.only(top: 1.5),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: tabColor,
                  width: 1.5,
                ),
              ),
            ),
            child: TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                hintText: "Phone Number",
                labelStyle: TextStyle(color: Colors.red),
                hintStyle: TextStyle(color: greyColor),
                fillColor: Colors.orange,
                focusColor: Colors.orange,
                border: InputBorder.none,

              ),
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ],
    );
  }
}
