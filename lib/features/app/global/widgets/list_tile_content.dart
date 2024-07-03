import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp/features/app/global/widgets/profile_widget.dart';

import '../../theme/style.dart';

class ListTileContent extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final Widget subTitleWidget;
  final File? image;
  final Widget? trailingWidget;
  final VoidCallback? onTap;

  const ListTileContent({
    super.key,
    this.imageUrl,
    this.image,
    required this.title,
    required this.subTitleWidget,
    this.trailingWidget,
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
          child: profileWidget(imageUrl: imageUrl, image: image),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: textColor),
      ),
      subtitle: subTitleWidget,
      trailing: trailingWidget,
    );
  }
}
