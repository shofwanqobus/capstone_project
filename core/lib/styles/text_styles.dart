import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:core/core.dart';

// text style
final TextStyle kHeading4 = GoogleFonts.inter(
    fontSize: 50, fontWeight: FontWeight.bold, color: backgroundPrimary2);
final TextStyle kHeading5 = GoogleFonts.inter(
    fontSize: 36, fontWeight: FontWeight.bold, color: backgroundPrimary2);
final TextStyle headingDetail =
    GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold, color: black);
final TextStyle kHeading6 = GoogleFonts.inter(
    fontSize: 19,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.15,
    color: black);
final TextStyle kSubtitle = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.15,
    color: black);
final TextStyle kBodyText =
    GoogleFonts.inter(fontSize: 13, letterSpacing: 0.25, color: black);

final TextStyle button = GoogleFonts.inter(
  fontSize: 24,
  color: backgroundPrimary2,
  fontWeight: FontWeight.bold,
);
final TextStyle button2 = GoogleFonts.inter(
  fontSize: 24,
  color: backgroundPrimary1,
  fontWeight: FontWeight.bold,
);
final TextStyle textButton = GoogleFonts.inter(
  fontSize: 16,
  color: black,
  letterSpacing: 0.15,
  fontWeight: FontWeight.bold,
);
final TextStyle textButton2 = GoogleFonts.inter(
  fontSize: 16,
  color: backgroundPrimary2,
  letterSpacing: 0.15,
  fontWeight: FontWeight.bold,
);

// text theme
final kTextTheme = TextTheme(
  headline4: kHeading4,
  headline5: kHeading5,
  headline6: kHeading6,
  subtitle1: kSubtitle,
  bodyText2: kBodyText,
);
