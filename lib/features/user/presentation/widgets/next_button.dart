import 'package:flutter/material.dart';

import '../../../app/theme/style.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Widget? child;
  final bool? isLoading;

  const NextButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.child,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: 120,
        height: 40,
        decoration: BoxDecoration(
          color: tabColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: isLoading == true
              ? SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    color: whiteColor,
                  ),
                )
              : Text(
                  title,
                  style: const TextStyle(
                    color: whiteColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
