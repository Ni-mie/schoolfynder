// ignore_for_file: unused_local_variable, unnecessary_brace_in_string_interps

import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:propzing_assignment/Utilities/constants.dart';
import '../Controller/auth_controller.dart';

class OTPScreen extends StatefulWidget {
  static String routeName = '/OtpScrn';
  const OTPScreen({Key? key, required this.phone, required this.verificationId})
      : super(key: key);

  final String phone;
  final String verificationId;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

bool isTapped = false;

class _OTPScreenState extends State<OTPScreen> {
  bool isResendTapped = false;
  int start = 30;
  final TextEditingController mobileController = TextEditingController();

  final TextEditingController _pinPutController = TextEditingController();

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          start = 30;
          isResendTapped = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20,
              ),
            ),
          ],
        ),
        centerTitle: true,
        title: const Text(
          'Verify phone',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 19,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Code is sent to ${widget.phone}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 57),
                    child: TextField(
                      controller: _pinPutController,
                    )),
                GestureDetector(
                  onTap: () {
                    if (widget.verificationId.isEmpty && widget.phone.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Wrong OTP")));
                    } else {
                      verifyOTPForSignIN(
                        context,
                        _pinPutController,
                        widget.phone,
                        widget.verificationId,
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: primary,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset.zero,
                          color: Colors.grey.shade300,
                          spreadRadius: 6,
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Verify',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text.rich(
                  TextSpan(
                    text: isResendTapped
                        ? 'Resend OTP in:  '
                        : 'Didn\'t receive an OTP?  ',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: isResendTapped ? '00:${start}' : 'Resend OTP',
                        style: TextStyle(
                          fontSize: isResendTapped ? 14 : 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          decoration: isResendTapped
                              ? TextDecoration.none
                              : TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => setState(() {
                                startTimer();
                                isResendTapped = true;
                              }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OTPScreenSignUp extends StatefulWidget {
  const OTPScreenSignUp(
      {Key? key,
      required this.phone,
      required this.name,
      required this.verificationId})
      : super(key: key);

  final String phone;
  final String name;
  final String verificationId;

  @override
  State<OTPScreenSignUp> createState() => _OTPScreenSignUpState();
}

bool isTapped1 = false;

class _OTPScreenSignUpState extends State<OTPScreenSignUp> {
  bool isResendTapped = false;
  int start = 30;
  final TextEditingController mobileController = TextEditingController();

  final TextEditingController _pinPutController = TextEditingController();

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          start = 30;
          isResendTapped = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20,
              ),
            ),
          ],
        ),
        centerTitle: true,
        title: const Text(
          'Verify phone',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 19,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Code is sent to ${widget.phone}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 57),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      controller: _pinPutController,
                    )),
                //verify otp container
                GestureDetector(
                  onTap: () {
                    if (widget.verificationId.isEmpty && widget.phone.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Wrong OTP")));
                    } else {
                      verifyOTPForSignUp(
                        context,
                        _pinPutController,
                        widget.phone,
                        widget.verificationId,
                        widget.name.toString(),
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: primary,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset.zero,
                          color: Colors.grey.shade300,
                          spreadRadius: 6,
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Verify',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text.rich(
                  TextSpan(
                    text: isResendTapped
                        ? 'Resend OTP in:  '
                        : 'Didn\'t receive an OTP?  ',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: isResendTapped ? '00:${start}' : 'Resend OTP',
                        style: TextStyle(
                          fontSize: isResendTapped ? 14 : 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          decoration: isResendTapped
                              ? TextDecoration.none
                              : TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => setState(() {
                                startTimer();
                                isResendTapped = true;
                              }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
