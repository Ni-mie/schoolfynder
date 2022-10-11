import 'package:flutter/material.dart';

import 'package:propzing_assignment/Views/signup_screen.dart';

import '../Controller/auth_controller.dart';
import '../Utilities/constants.dart';
import '../Utilities/custombutton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var phoneController = TextEditingController();

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
                child: Image.asset(
                  'asset/41481.jpg',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(
                          color: textLightColor,
                        )),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Login',
                          style: bodyText2(
                            color: textLightColor,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Expanded(
                            child: Divider(
                          color: textLightColor,
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
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
                          sendOTPForSignIN(context, phoneController);
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: Wrap(children: [
                        Text('Not a member? ', style: bodyText1()),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupScreen()));
                            },
                            child: Text(
                              'Signup here',
                              style: bodyText1(),
                            )),
                      ]),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
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
