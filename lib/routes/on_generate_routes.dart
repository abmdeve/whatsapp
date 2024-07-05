import 'package:flutter/material.dart';
import 'package:whatsapp/features/user/domain/entities/user_entity.dart';
import 'package:whatsapp/features/user/presentation/pages/edit_profile_page.dart';

import '../features/app/const/page_const.dart';
import '../features/call/presentation/pages/call_contacts_page.dart';
import '../features/chat/pages/single_chat_page.dart';
import '../features/home/contacts_page.dart';
import '../features/settings/settings_page.dart';
import '../features/status/presentation/pages/my_status_page.dart';

class OnGenerateRoutes {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;
    final name = settings.name;

    switch (name) {
      case PageConst.contactUsersPage:
        {
          return materialPageBuilder(const ContactsPage());
        }
      case PageConst.settingsPage:
        {
          if (args is String) {
            return materialPageBuilder(SettingsPage(
              uid: args,
            ));
          } else {
            return materialPageBuilder(const ErrorPage());
          }
        }
      case PageConst.editProfilePage:
        {
          if (args is UserEntity) {
            return materialPageBuilder(EditProfilePage(
              currentUser: args,
            ));
          } else {
            return materialPageBuilder(const ErrorPage());
          }
        }
      case PageConst.myStatusPage:
        {
          return materialPageBuilder(const MyStatusPage());
        }
      case PageConst.callContactPage:
        {
          return materialPageBuilder(const CallContactsPage());
        }

      case PageConst.singleChatPage:
        {
          return materialPageBuilder(const SingleChatPage());
        }
    }
  }
}

dynamic materialPageBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ERROR"),
      ),
      body: Center(
        child: Text("ERROR_BODY"),
      ),
    );
  }
}
