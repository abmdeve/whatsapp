import 'package:flutter/material.dart';

import '../../../app/global/date/date_formats.dart';
import '../../../app/global/widgets/list_tile_content.dart';
import '../../../app/theme/style.dart';

class CallHistoryPage extends StatefulWidget {
  const CallHistoryPage({super.key});

  @override
  State<CallHistoryPage> createState() => _CallHistoryPageState();
}

class _CallHistoryPageState extends State<CallHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Recent",
                style: TextStyle(
                  fontSize: 15,
                  color: greyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTileContent(
                    title: "Username",
                    subTitleWidget: Row(
                      children: [
                        const Icon(
                          Icons.call_made,
                          color: Colors.green,
                          size: 19,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          formatDateTime(
                            DateTime.now(),
                          ),
                        ),
                      ],
                    ),
                    trailingWidget: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.call,
                        color: tabColor,
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
