import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp/features/app/global/widgets/user_image.dart';

import '../../theme/style.dart';

class MyStatusContent extends StatelessWidget {
  final String? imageUrl;
  final File? image;
  final String title;
  final String value;
  final String titleValue;
  final VoidCallback onTap;
  final Function(String) onSelected;

  const MyStatusContent({
    super.key,
    this.imageUrl,
    this.image,
    required this.title,
    required this.value,
    required this.titleValue,
    required this.onTap,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const UserImage(),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
        PopupMenuButton(
          icon: Icon(
            Icons.more_vert,
            color: greyColor.withOpacity(.5),
          ),
          color: appBarColor,
          iconSize: 28,
          onSelected: onSelected,
          itemBuilder: (context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: value,
              child: GestureDetector(
                onTap: onTap,
                child: Text(
                  titleValue,
                  style: const TextStyle(color: textColor),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
