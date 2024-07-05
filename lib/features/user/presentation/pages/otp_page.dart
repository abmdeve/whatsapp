import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

import '../../../app/theme/style.dart';
import '../cubit/credential/credential_cubit.dart';
import '../widgets/next_button.dart';
import '../widgets/pin_code_widget.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Center(
                    child: Text(
                      "Verify your OTP",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: tabColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Enter your OTP for the WhatsApp Clone. Verification (so that you will be moved for further steps to complete)",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: textColor),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  PinCodeWidget(
                      otpController: _otpController, onComplete: (pinCode) {}),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            NextButton(
              isLoading: false,
              onPressed: _submitSmsCode,
              /*onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const InitialProfileSubmitPage(),
                    ),
                );
              },*/
              title: "Next",
            ),
          ],
        ),
      ),
    );
  }

  void _submitSmsCode() {
    debugPrint("OTP CODE ${_otpController.text}");
    if (_otpController.text.isNotEmpty) {
      debugPrint("PHONE NUMBER ========================== ${_otpController.text}");
      BlocProvider.of<CredentialCubit>(context)
          .submitSmsCode(smsCode: _otpController.text,
      );
    }
  }
}
