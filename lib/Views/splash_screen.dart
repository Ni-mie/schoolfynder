import 'dart:async';

import 'package:flutter/material.dart';
import 'package:propzing_assignment/Views/login_screen.dart';

import '../Utilities/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Future startTime() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      if (mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    startTime();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Container(
            height: scHeight(context),
            width: scWidth(context),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: AssetImage('asset/splash screen.jpg'),
                    fit: BoxFit.cover)),
          ),
        ),
      ],
    ));
  }
}
