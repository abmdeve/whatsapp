import 'package:flutter/material.dart';

import '../../../app/const/page_const.dart';
import '../../../app/global/date/date_formats.dart';
import '../../../app/global/widgets/list_tile_content.dart';
import '../../../app/global/widgets/user_icon_positioned.dart';
import '../../../app/theme/style.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserIconPositioned(
              backgroundColor: tabColor,
              transparentColorOrNot: backgroundColor,
              title: "My status",
              subTitle: "Tap to add your status update",
              iconPositioned: const Icon(
                Icons.add,
                color: textColor,
              ),
              trailing: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PageConst.myStatusPage);
                },
                child: Icon(
                  Icons.more_horiz_outlined,
                  color: greyColor.withOpacity(.5),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Recent updates",
                style: TextStyle(
                  fontSize: 15,
                  color: greyColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTileContent(
                      title: "Username",
                      subTitleWidget: Text(
                        formatDateTime(
                          DateTime.now(),
                        ),
                        style: const TextStyle(color: greyColor),
                      ));
                }),
          ],
        ),
      ),
    );
  }
}
