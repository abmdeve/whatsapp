import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp/features/app/global/widgets/user_image.dart';

import '../../theme/style.dart';

class UserIconPositioned extends StatelessWidget {
  final String? imageUrl;
  final File? image;
  final String title;
  final String subTitle;
  final Widget trailing;
  final Widget? iconPositioned;
  final Color? backgroundColor;
  final Color transparentColorOrNot;
  final VoidCallback? onTap;

  const UserIconPositioned({
    super.key,
    this.image,
    this.imageUrl,
    this.iconPositioned,
    this.backgroundColor,
    required this.transparentColorOrNot,
    required this.title,
    required this.subTitle,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          children: [
            Stack(
              children: [
                UserImage(
                  imageUrl: imageUrl,
                  image: image,
                ),
                Positioned(
                  right: 10,
                  bottom: 8,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          width: 2,
                          color: transparentColorOrNot,
                        )),
                    child: Center(
                      child: iconPositioned,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, color: textColor),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    subTitle,
                    style: const TextStyle(color: greyColor),
                  ),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
