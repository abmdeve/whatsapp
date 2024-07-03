import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp/features/app/global/widgets/profile_widget.dart';

class UserImage extends StatelessWidget {
  final String? imageUrl;
  final File? image;
  final double? size;

  const UserImage({
    super.key,
    this.imageUrl,
    this.image,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: size ?? 60 ,
      height: size ?? 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: profileWidget(imageUrl: imageUrl, image: image),
      ),
    );
  }
}
