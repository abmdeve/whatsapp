import 'package:flutter/material.dart';
import 'package:whatsapp/features/app/theme/style.dart';

class InputProfileItem extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const InputProfileItem({
    super.key,
    required this.onTap,
    required this.controller,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Icon(
              icon,
              color: greyColor,
              size: 25,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: TextFormField(
                    style: TextStyle(
                      color: textColor,
                    ),
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: description,
                      hintStyle: TextStyle(
                        color: textColor,
                      ),
                      suffixIcon: const Icon(
                        Icons.edit_rounded,
                        color: tabColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
