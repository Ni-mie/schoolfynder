import 'package:flutter/material.dart';

import 'constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.ontap,
    this.elevation = 0,
    this.horizontalPadding = 0.0,
    this.isBorder = false,
    this.textcolor = Colors.white,
    this.radius = 8,
    this.buttonColor = primary,
    this.isDoubleInfinity = false,
    // required this.doubleInifinityHeight,
  }) : super(key: key);
  final String text;

  final VoidCallback ontap;
  final Color textcolor;
  final Color buttonColor;

  ///when we want button with border, set true
  ///by deafult its false
  final bool isBorder;
  final double elevation;
  final double radius;

  final double horizontalPadding;
  // final double doubleInifinityHeight;

  /// its used when we want two button in Row
  /// by deafult false
  final bool isDoubleInfinity;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isDoubleInfinity == false ? double.infinity : null,
      height: isDoubleInfinity == false
          ? scHeight(context) * 0.06
          : scHeight(context) * 0.055,
      child: ElevatedButton(
        style: isBorder == false
            ? ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                elevation: elevation,
                primary: buttonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius),
                    side: BorderSide.none),
              )
            : ElevatedButton.styleFrom(
                elevation: elevation,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                primary: Colors.white,
                onPrimary: primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius),
                    side: const BorderSide(width: 1, color: primary))),
        onPressed: ontap,
        child: Text(
          text,
          style: isDoubleInfinity == false
              ? headline1Normal(color: isBorder == true ? primary : textcolor)
              : bodyText1(color: isBorder == true ? primary : textcolor),
        ),
      ),
    );
  }
}
