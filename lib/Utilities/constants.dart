// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const textColor = Colors.black;
const textLightColor = Color(0xFFFFFFFF);
const primary = Color(0xFFF115740);

showMySnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

///Media Query screen height
double scHeight(context) {
  return MediaQuery.of(context).size.height;
}

///media Query screen width
double scWidth(context) {
  return MediaQuery.of(context).size.width;
}

BoxDecoration boxBorderDecoration(
    {double borderRadius = 8, Color color = textLightColor}) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: color));
}

TextStyle headline1({Color color = textColor}) {
  return GoogleFonts.poppins(
      fontWeight: FontWeight.w600, fontSize: 22, color: color);
}

TextStyle headline1Normal({Color color = textColor}) {
  return GoogleFonts.poppins(
      fontWeight: FontWeight.w500, fontSize: 18, color: color);
}

TextStyle headline1ExtraLarge({Color color = textColor}) {
  return GoogleFonts.poppins(
      fontWeight: FontWeight.w600, fontSize: 24, color: textLightColor);
}

TextStyle bodyText1(
    {Color color = textColor,
    TextDecoration textDecoration = TextDecoration.none}) {
  return GoogleFonts.poppins(
      decoration: textDecoration,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: color);
}

TextStyle bodyText1Bold({
  Color color = textColor,
}) {
  return GoogleFonts.poppins(
      fontWeight: FontWeight.w600, fontSize: 16, color: color);
}

TextStyle bodyText2({Color color = textColor}) {
  return GoogleFonts.poppins(
      fontWeight: FontWeight.w400, fontSize: 14, color: color);
}

TextStyle bodyText3({Color color = textColor}) {
  return GoogleFonts.poppins(
      fontWeight: FontWeight.w400, fontSize: 12, color: color);
}

TextStyle bodyText3Bold({Color color = textColor}) {
  return GoogleFonts.poppins(
      fontWeight: FontWeight.w600, fontSize: 12, color: color);
}
