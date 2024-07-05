import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:typed_data';

import 'package:whatsapp/features/app/global/widgets/contact_widget.dart';
import 'package:whatsapp/features/app/global/widgets/go_back_widget.dart';
import 'package:whatsapp/features/user/presentation/cubit/get_device_number/get_device_number_cubit.dart';
import 'package:whatsapp/features/user/presentation/cubit/get_device_number/get_device_number_state.dart';

import '../app/theme/style.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<GetDeviceNumberCubit>(context).getDeviceNumber();
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
      body: BlocBuilder<GetDeviceNumberCubit, GetDeviceNumberState>(
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
      }),
    );
  }
}
