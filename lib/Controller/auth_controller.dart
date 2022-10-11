// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propzing_assignment/Views/home_screen.dart';
import 'package:propzing_assignment/Views/splash_screen.dart';

import '../Views/login_screen.dart';

import '../Views/otpscreen.dart';

class InitializerFirebaseUser extends StatefulWidget {
  const InitializerFirebaseUser({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InitializerFirebaseUserState createState() =>
      _InitializerFirebaseUserState();
}

class _InitializerFirebaseUserState extends State<InitializerFirebaseUser> {
  late FirebaseAuth _auth;
  User? _user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _user == null
            ? const SplashScreen()
            : const HomeScreen();
  }
}

//<------------------------------- Firebase Send Otp Method --------------------------->//
void sendOTPForSignIN(
    BuildContext context, TextEditingController controller) async {
  String phone = controller.text.trim();
  // var useId = FirebaseAuth.instance.currentUser!.uid.substring(0, 20);
  await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: (verificationId, resendToken) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OTPScreen(
                      phone: controller.text.trim(),
                      verificationId: verificationId,
                    )));
      },
      verificationCompleted: (credential) {},
      verificationFailed: (ex) {
        log(ex.code.toString());
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      timeout: const Duration(seconds: 30));
}

//<------------------------------- Firebase Send Otp Method --------------------------->//
void sendOTPForSignUp(
    BuildContext context, TextEditingController controller, String name) async {
  String phone = controller.text.trim();
  // var useId = FirebaseAuth.instance.currentUser!.uid.substring(0, 20);
  await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: (verificationId, resendToken) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OTPScreenSignUp(
                      phone: controller.text.trim(),
                      name: name,
                      verificationId: verificationId,
                    )));
      },
      verificationCompleted: (credential) {},
      verificationFailed: (ex) {
        log(ex.code.toString());
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      timeout: const Duration(seconds: 30));
}

//<----------------------- Firebase Verify Otp Method --------------------------->//
void verifyOTPForSignIN(BuildContext context, TextEditingController controller,
    String mobile, String verificationId) async {
  String otp = controller.text.trim();

  PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId, smsCode: otp);

  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCredential.user != null) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  } on FirebaseAuthException catch (ex) {
    log(ex.code.toString());
  }
}

void verifyOTPForSignUp(BuildContext context, TextEditingController controller,
    String mobile, String verificationId, String name) async {
  String otp = controller.text.trim();

  PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId, smsCode: otp);

  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCredential.user != null) {
      var userId = FirebaseAuth.instance.currentUser!.uid.substring(0, 20);
      FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .set({"name": name, "mobile": mobile, "uid": userId});
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  } on FirebaseAuthException catch (ex) {
    log(ex.code.toString());
  }
}

//<--------------------- Firebase Logout Method ------------------------>//
Future<void> logOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ),
  );
}
