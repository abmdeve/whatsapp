import 'package:flutter/material.dart';

import '../../theme/style.dart';

class AttachWindowItem extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final String? title;
  final VoidCallback? onTap;

  const AttachWindowItem({
    super.key,
    this.onTap,
    this.icon,
    this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(icon, color: textColor,),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "$title",
            style: const TextStyle(color: greyColor, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
