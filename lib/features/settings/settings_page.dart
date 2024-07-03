import 'package:flutter/material.dart';

import '../app/global/widgets/select_item_widget.dart';
import '../app/global/widgets/user_icon_positioned.dart';
import '../app/theme/style.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
          const UserIconPositioned(
            backgroundColor: Colors.transparent,
            transparentColorOrNot: Colors.transparent,
            title: "My status",
            subTitle: "Tap to add your status update",
            iconPositioned: Text(""),
            trailing: Icon(
              Icons.qr_code_sharp,
              color: tabColor,
            ),
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
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
