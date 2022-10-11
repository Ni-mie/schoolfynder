import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Controller/auth_controller.dart';
import '../Utilities/constants.dart';
import '../Utilities/custombutton.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  Map userData = {};

  // ignore: prefer_typing_uninitialized_variables
  var userId;

  _fetchUserData() async {
    await FirebaseFirestore.instance
        .collection('Users')
        //
        .get()
        .then((value) {
      for (var doc in value.docs) {
        userData = doc.data();
        // log(userData.toString());
        setState(() {});
      }
    });
  }

  @override
  initState() {
    super.initState();
    _fetchUserData();
  }

  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  child: Image.asset('asset/41481.jpg')),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Expanded(
                            child: Divider(
                          color: textLightColor,
                        )),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: Divider(
                          color: textLightColor,
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 30),
                          hintText: 'Enter your name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 30),
                          hintText: 'Enter your mobile no',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        text: 'Continue',
                        ontap: () {
                          if (userData['mobile'] == phoneController.text) {
                            log(userData['mobile']);
                            showMySnackBar(
                                context, "You are already registered");
                          } else if (nameController.text.isNotEmpty &&
                              phoneController.text.isNotEmpty) {
                            if (nameController.text.isEmpty &&
                                phoneController.text.isEmpty) {
                              showMySnackBar(context, "Can not be empty!");
                            } else {
                              sendOTPForSignUp(context, phoneController,
                                  nameController.text);
                            }
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: Wrap(children: [
                        Text('Already a member? ', style: bodyText1()),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            child: Text('Login here', style: bodyText1())),
                      ]),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
