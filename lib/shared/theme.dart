import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = const Color(0xff98B66E);
Color primarySoftColor = const Color(0xffC5E5A5);
Color secondaryColor = const Color(0xffF9D876);
Color secondarySoftColor = const Color(0xffFBE39D);
Color blackColor = const Color(0xff000000);
Color blackColorTrans = Color.fromRGBO(0, 0, 0, 0.5);
Color whiteColor = const Color(0xffFFFFFF);
Color whiteColorTrans = Color.fromRGBO(255, 255, 255, 0.5);
Color greyColor = const Color(0xffA7ACB1);
Color greyColorTrans = Color.fromRGBO(167, 172, 177, 1);
Color successColor = const Color(0xff75B798);
Color warningColor = const Color(0xffFFDA6A);
Color dangerColor = const Color(0xffCA7485);

TextStyle blackStyleText = GoogleFonts.openSans(
  color: blackColor,
);
TextStyle whiteStyleText = GoogleFonts.openSans(
  color: whiteColor,
);

// Font Weight
FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w500;
FontWeight bold = FontWeight.w800;

// Font Size
TextStyle h1 = TextStyle(fontSize: 26);
TextStyle h2 = TextStyle(fontSize: 24);
TextStyle h3 = TextStyle(fontSize: 22);
TextStyle h4 = TextStyle(fontSize: 18);
TextStyle h5 = TextStyle(fontSize: 16);
