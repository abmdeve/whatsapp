import 'package:flutter/material.dart';

import '../../../app/global/widgets/list_tile_content.dart';
import '../../../app/theme/style.dart';

class CallContactsPage extends StatefulWidget {
  const CallContactsPage({super.key});

  @override
  State<CallContactsPage> createState() => _CallContactsPageState();
}

class _CallContactsPageState extends State<CallContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Contacts",
          style: TextStyle(color: textColor),
        ),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return const ListTileContent(
            title: "Username",
            subTitleWidget: const Text(
              "Hey there! I'm using WhatsApp",
              style: TextStyle(color: textColor),
            ),
            trailingWidget: Wrap(
              children: [
                Icon(
                  Icons.call,
                  color: tabColor,
                  size: 22,
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.videocam_rounded,
                  color: tabColor,
                  size: 22,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
