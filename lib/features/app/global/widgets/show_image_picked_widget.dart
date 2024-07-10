import 'dart:io';
import 'package:flutter/material.dart';
import 'package:whatsapp/features/app/global/widgets/user_image.dart';
import 'package:whatsapp/features/app/theme/style.dart';

showImagePickedBottomModalSheet(BuildContext context,
    {File? file, VoidCallback? onTap, String? recipientName}) {
  showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder: (context) {
        return Container(
          color: backgroundColor,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: UserImage(
                  image: file,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close_outlined),
                      ),
                      Row(
                        children: [
                          Icon(Icons.crop, size: 30, color: textColor,),
                          SizedBox(width: 20,),
                          Icon(Icons.email_outlined, size: 30, color: textColor,),
                          SizedBox(width: 20,),
                          Icon(Icons.text_fields, size: 30, color: textColor,),
                          SizedBox(width: 20,),
                          Icon(Icons.edit_outlined, size: 30, color: textColor,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: appBarColor,
                        ),
                        child: Text("$recipientName"),
                      ),

                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: tabColor,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.send_outlined,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
