import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kPrimaryColor = const Color(0xffF4CB21);
Color kBlackColor = const Color(0xff000000);
Color kWhiteColor = const Color(0xffFFFFFF);
Color kGreyColor = const Color(0xffEDEDED);
Color kGreenColor = const Color(0xff00C100);
Color kBlueColor = const Color(0xff1363DF);
Color kRedColor = const Color(0xffFF0000);
Color kBackgroundColor = const Color(0xffEDEDED);
Color kInactiveColor = const Color(0xffDBD7EC);
Color kTransparentColor = Colors.transparent;

TextStyle blackStyleText = GoogleFonts.openSans(
  color: kBlackColor,
);
TextStyle whiteStyleText = GoogleFonts.openSans(
  color: kWhiteColor,
);
TextStyle greyStyleText = GoogleFonts.openSans(
  color: kGreyColor,
);
TextStyle greenStyleText = GoogleFonts.openSans(
  color: kGreenColor,
);
TextStyle redStyleText = GoogleFonts.openSans(
  color: kRedColor,
);
TextStyle orangeStyleText = GoogleFonts.openSans(
  color: kPrimaryColor,
);
TextStyle blueStyleText = GoogleFonts.openSans(
  color: kBlueColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;

TextStyle titleText = TextStyle(fontSize: 24, fontWeight: bold);
