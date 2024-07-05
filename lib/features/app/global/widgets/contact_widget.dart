import 'package:flutter/material.dart';

import '../../theme/style.dart';

class ContactWidget extends StatelessWidget {
  final String title;
  final Widget imageWidget;
  final String subTitle;
  final VoidCallback? onTap;

  const ContactWidget({
    super.key,
    required this.imageWidget,
    required this.title,
    required this.subTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: imageWidget,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: textColor),
      ),
      subtitle: Text(
        subTitle,
        //style: const TextStyle(fontSize: 16, color: textColor),
      ),
    );
  }
}
