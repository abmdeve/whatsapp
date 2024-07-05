import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/features/app/const/app_const.dart';
import 'package:whatsapp/features/app/global/widgets/input_profile_item.dart';
import 'package:whatsapp/features/app/global/widgets/settings_item_widget.dart';
import 'package:whatsapp/features/app/global/widgets/user_image.dart';
import 'package:whatsapp/features/app/theme/style.dart';
import 'package:whatsapp/features/user/domain/entities/user_entity.dart';
import 'package:whatsapp/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:whatsapp/features/user/presentation/widgets/next_button.dart';
import 'package:whatsapp/storage/storage_provider.dart';


class EditProfilePage extends StatefulWidget {
  final UserEntity currentUser;

  const EditProfilePage({super.key, required this.currentUser});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _usernameController = TextEditingController();

  TextEditingController _aboutController = TextEditingController();

  File? _image;
  bool? _isProfileUpdating = false;

  Future selectImage() async {
    try {
      final pickedFile = await ImagePicker.platform.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          debugPrint("NO IMAGE HAS BEEN SELECTED");
        }
      });
    } catch (e) {
      toast("SOME ERROR OCCURED $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _usernameController =
        TextEditingController(text: widget.currentUser.username);
    _aboutController = TextEditingController(text: widget.currentUser.status);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text("Profile", style: TextStyle(color: textColor),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: UserImage(
                        imageUrl: widget.currentUser.profileUrl,
                        image: _image,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    right: 15,
                    child: GestureDetector(
                      onTap: selectImage,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: tabColor,
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: textColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            InputProfileItem(
              onTap: () {},
              controller: _usernameController,
              title: "Name",
              description: "Enter username",
              icon: Icons.person,
            ),
            InputProfileItem(
              onTap: () {},
              controller: _aboutController,
              title: "About",
              description: "Hey there I'm using WhatsApp",
              icon: Icons.info_outline,
            ),
            SettingsItemWidget(
                onTap: (){},
                title: "Phone",
                description: "${widget.currentUser.phoneNumber}",
                icon: Icons.call,
            ),
            SizedBox(height: 40,),
            NextButton(
                onPressed: submitProfileInfo,
                title: "Save",
                isLoading: _isProfileUpdating,
            ),
          ],
        ),
      ),
    );
  }

  void submitProfileInfo() {
    if (_image != null) {
      StorageProviderRemoteDataSource.uploadProfileImage(
          file: _image!,
          onComplete: (onProfileUpdateComplete) {
            setState(() {
              _isProfileUpdating = onProfileUpdateComplete;
            });
          }
      ).then((profileImageUrl) {
        _profileInfo(profileUrl: profileImageUrl);
      });
    } else {
      _profileInfo(profileUrl: widget.currentUser.profileUrl);
    }
  }

  void _profileInfo({String? profileUrl}) {
    if (_usernameController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context)
          .updateUser(
        user: UserEntity(
          uid: widget.currentUser.uid,
          username: _usernameController.text,
          phoneNumber: widget.currentUser.phoneNumber,
          status: _aboutController.text,
          isOnline: false,
          profileUrl: profileUrl,
        ),
      ).then((value) {
        toast("PROFILE _UPDATE");
      });
    }
  }
}
