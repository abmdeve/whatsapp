import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/features/app/const/page_const.dart';
import 'dart:typed_data';

import 'package:whatsapp/features/app/global/widgets/contact_widget.dart';
import 'package:whatsapp/features/app/global/widgets/go_back_widget.dart';
import 'package:whatsapp/features/app/global/widgets/user_image.dart';
import 'package:whatsapp/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp/features/user/presentation/cubit/get_device_number/get_device_number_cubit.dart';
import 'package:whatsapp/features/user/presentation/cubit/get_device_number/get_device_number_state.dart';
import 'package:whatsapp/features/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:whatsapp/features/user/presentation/cubit/get_single_user/get_single_user_state.dart';
import 'package:whatsapp/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:whatsapp/features/user/presentation/cubit/user/user_state.dart';

import '../app/theme/style.dart';

class ContactsPage extends StatefulWidget {
  final String uid;

  const ContactsPage({super.key, required this.uid});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<UserCubit>(context).getAllUsers();
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GoBackWidget(),
        title: const Text(
          "Select Contacts",
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
      body: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, state) {
          if (state is GetSingleUserLoaded) {
            final currentUser = state.singleUser;

            return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
              if (state is UserLoaded) {
                final contacts = state.users
                    .where((user) => user.uid != widget.uid)
                    .toList();

                if (contacts.isEmpty) {
                  return Center(
                    child: Text(
                      "NO CONTACTS YET!",
                      style: TextStyle(color: textColor),
                    ),
                  );
                }

                return ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return ContactWidget(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            PageConst.singleChatPage,
                            arguments: MessageEntity(
                              senderUid: currentUser.uid,
                              recipientUid: contact.uid,
                              senderName: currentUser.username,
                              recipientName: contact.username,
                              senderProfile: currentUser.profileUrl,
                              recipientProfile: contact.profileUrl,
                            ),
                          );
                        },
                        imageWidget: UserImage(
                          imageUrl: contact.profileUrl,
                        ),
                        title: "${contact.username}",
                        subTitle: "${contact.status}",
                      );
                    });
              }
              return Center(
                child: CircularProgressIndicator(
                  color: tabColor,
                ),
              );
            });
          }
          return Center(
            child: CircularProgressIndicator(
              color: tabColor,
            ),
          );
        },
      ),
    );
  }
}

// FIXME: Logic to fetch contacts of the phone

/*
BlocBuilder<GetDeviceNumberCubit, GetDeviceNumberState>(
          builder: (context, state) {
        if (state is GetDeviceNumberLoaded) {
          final contacts = state.contacts;
          return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ContactWidget(
                    imageWidget: Image.memory(
                      contact.photo ?? Uint8List(0),
                      errorBuilder: (context, error, stackTrace){
                        return Image.asset("assets/profile_default.png");
                      },
                    ),
                    title: "${contact.name!.first} ${contact.name!.last}",
                    subTitle: "Hey there! I'm using WhatsApp Clone",
                );
              });
        }
        return Center(
          child: CircularProgressIndicator(
            color: tabColor,
          ),
        );
      })
*/
