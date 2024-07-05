import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/features/app/const/page_const.dart';
import 'package:whatsapp/features/app/global/widgets/dialog_widget.dart';
import 'package:whatsapp/features/user/domain/entities/user_entity.dart';
import 'package:whatsapp/features/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:whatsapp/features/user/presentation/cubit/get_single_user/get_single_user_state.dart';

import '../app/global/widgets/select_item_widget.dart';
import '../app/global/widgets/user_icon_positioned.dart';
import '../app/theme/style.dart';

class SettingsPage extends StatefulWidget {
  final String uid;

  const SettingsPage({super.key, required this.uid});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  UserEntity singleUser = UserEntity(
    username: "Default username",
    status: "Default status user",
    isOnline: false,
    phoneNumber: "+242 05 546 87 16",
    uid: "1",
    profileUrl: "assets/profile_default.png",
    email: "",
  );

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: textColor),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
            builder: (context, state) {
              if (state is GetSingleUserLoaded) {
                final singleUser = state.singleUser;

                return UserIconPositioned(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      PageConst.editProfilePage,
                      arguments: singleUser,
                    );
                  },
                  imageUrl: singleUser.profileUrl,
                  backgroundColor: Colors.transparent,
                  transparentColorOrNot: Colors.transparent,
                  title: "${singleUser.username}",
                  subTitle: "${singleUser.status}",
                  iconPositioned: Text(""),
                  trailing: Icon(
                    Icons.qr_code_sharp,
                    color: tabColor,
                  ),
                );
              }
              return UserIconPositioned(
                onTap: () {
                  debugPrint("MA VIE N'EST QU'UN SOUFLE<<<<<>>><");
                  Navigator.pushNamed(
                    context,
                    PageConst.editProfilePage,
                    arguments: singleUser,
                  );
                },
                backgroundColor: Colors.transparent,
                transparentColorOrNot: Colors.transparent,
                title: "...",
                subTitle: "...",
                iconPositioned: Text(""),
                trailing: Icon(
                  Icons.qr_code_sharp,
                  color: tabColor,
                ),
              );
            },
          ),
          const SizedBox(
            height: 2,
          ),
          Container(
            width: double.infinity,
            height: 0.5,
            color: greyColor.withOpacity(.4),
          ),
          const SizedBox(
            height: 10,
          ),
          SelectItemWidget(
            title: "Account",
            description: "Security application, change number",
            icon: Icons.key,
            onTap: () {},
          ),
          SelectItemWidget(
            title: "Privacy",
            description: "Bloc contacts, disappearing messages",
            icon: Icons.lock,
            onTap: () {},
          ),
          SelectItemWidget(
            title: "Chat",
            description: "Theme, wallpapers, chat history",
            icon: Icons.message,
            onTap: () {},
          ),
          SelectItemWidget(
            title: "Logout",
            description: "Logout from WhatsApp Clone",
            icon: Icons.exit_to_app,
            onTap: () {
              displayAlertDialog(
                context,
                onTap: () {},
                confirmTitle: "Logout",
                content: "Are you sure you want to logout ?",
              );
            },
          ),
        ],
      ),
    );
  }
}
