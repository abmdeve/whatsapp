import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/features/app/const/page_const.dart';
import 'package:whatsapp/features/user/domain/entities/user_entity.dart';
import 'package:whatsapp/features/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:whatsapp/storage/storage_provider.dart';

import '../../../app/const/app_const.dart';
import '../../../app/global/widgets/profile_widget.dart';
import '../../../app/theme/style.dart';
import '../../../home/home_page.dart';
import '../widgets/next_button.dart';

class InitialProfileSubmitPage extends StatefulWidget {
  final String phoneNumber;

  const InitialProfileSubmitPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<InitialProfileSubmitPage> createState() =>
      _InitialProfileSubmitPageState();
}

class _InitialProfileSubmitPageState extends State<InitialProfileSubmitPage> {
  File? _image;
  final TextEditingController _usernameController = TextEditingController();
  bool _isProfileUpdating = false;

  Future selectImage() async {
    try {
      final pickedFile = await ImagePicker.platform
          .getImageFromSource(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          debugPrint("NO IMAGE HAS BEEN SELECTED");
        }
      });
    } catch (e) {
      toast("SOME ERROR OCCURRED $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: Text(
                "Profile Info",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Please provide your name and an optional profile photo",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: textColor),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: selectImage,
              child: SizedBox(
                width: 50,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: profileWidget(image: _image),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              margin: const EdgeInsets.only(top: 1.5),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: tabColor,
                    width: 1.5,
                  ),
                ),
              ),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: "Username",
                  hintStyle: TextStyle(color: textColor),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: textColor),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            NextButton(
              onPressed: submitProfileInfo,
              /*onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                  (route) => false,
                );
              },*/
              title: "Next",
              isLoading: false,
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
          }).then((profileImageUrl) {
        _profileInfo(
          profileUrl: profileImageUrl,
        );
      });
      /*Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(
            uid: "1",
          ),
        ),
        (route) => false,
      );*/
    } else {
      _profileInfo(
        profileUrl: "",
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(
            uid: "1",
          ),
        ),
        (route) => false,
      );
    }
  }

  void _profileInfo({String? profileUrl}) {
    if (_usernameController.text.isNotEmpty) {
      debugPrint(
          "USER LOGIN WITH NUMBER PHONE ------------> ${_usernameController.text} <-------<<${widget.phoneNumber}>>>>-----");
      BlocProvider.of<CredentialCubit>(context).submitProfileInfo(
        user: UserEntity(
          email: "",
          username: _usernameController.text,
          phoneNumber: widget.phoneNumber,
          status: "Hey There! I'm using WhatsApp",
          isOnline: false,
          profileUrl: profileUrl,
        ),
      );
    }
  }
}
