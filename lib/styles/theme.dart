import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color purpleColor = const Color(0xff5843BE);
Color orangeColor = const Color(0xffFF9376);
Color blackColor = const Color(0xff000000);
Color whiteColor = const Color(0xffFFFFFF);
Color greyColor = const Color(0xff82868E);

double edge = 24;

TextStyle blackTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: blackColor,
);

TextStyle whiteTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: whiteColor,
);

TextStyle greyTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w300,
  color: greyColor,
);

TextStyle purpleTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: purpleColor,
);

TextStyle regularTextStyle = GoogleFonts.poppins(
  fontWeight: FontWeight.w400,
  color: blackColor,
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: purpleColor,
  hintColor: blackColor,
  textTheme: TextTheme(
    bodyLarge: blackTextStyle,
    bodyMedium: regularTextStyle,
    titleLarge: blackTextStyle.copyWith(fontSize: 24),
    titleMedium: greyTextStyle.copyWith(fontSize: 16),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: purpleColor,
  hintColor: whiteColor,
  textTheme: TextTheme(
    bodyLarge: whiteTextStyle,
    bodyMedium: whiteTextStyle,
    titleLarge: whiteTextStyle.copyWith(fontSize: 24),
    titleMedium: greyTextStyle.copyWith(fontSize: 16),
  ),
);
