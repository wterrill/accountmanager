import 'dart:ui';
import 'package:flutter/material.dart';

class ColorDefs {
  static Color colorTopHeader =
      Color(0xFFFEFEFE); // off white for main header and text and borders
  static Color colorDarkBackground =
      Color(0xFF343434); // grey for big background and row
  static Color colorAlternatingDark =
      Color(0xFF393939); // grey for alternating lines
  static Color colorCalendarHeader =
      Color(0xFF5B5B5B); // light gray for calendar header
  static Color colorButton1Background =
      Color(0xFF717171); // left / right button background
  static Color colorTimeBackground =
      Color(0xFF303030); // background of time column / date row
  static Color colorUserAccent = Colors.green; // Profile image and outline
  static Color colorTransparentOffDayBackground =
      Color(0x114ED4DF); // For the OFF day overlay
  static Color colorTransparentOffDayText =
      Color(0x88919C9D); // For the OFF day overlay
  static Color colorTopDrawerBackground = Color(0xFF3C3C3C); //
  static Color colorTopDrawerAlternating = Color(0xFF474747);
  static Color colorBigDrawerBronze = Color(0xFFA36422);
  static Color colorDarkest = Color(0xFF262626);
  static Color colorHighlight = Color(0x664ED4DF);

  static Color colorAudit1 = Color(0xFFD84342);
  static Color colorAudit2 = Color(0xFF4ED4DF);
  static Color colorAudit3 = Color(0xFF26BF7D);
  static Color colorAudit4 = Color(0xFFD8AD43);
  // static Color colorAudit5 = Color(0xFFFFFFFF);

  static Color colorLoginBackground = Color(0xFFE7EFFE);

  static Color colorDisabledBackground = Color(0xAA555555);

  static Color colorLogoDarkGreen = Color(0xAA1C4326);
  static Color colorLogoLightGreen = Color(0xAA148E44);
  static Color colorAnotherDarkGreen = Color(0xAA0F843E);

///////////////////////////////////////////////////////////////////////
// Questionnaire
  // static Color colorAlternateDark = Color(0xFFd4d4d4);
  static Color colorAlternateDark = Color(0xFFC9C9C9);
  static Color colorAlternateLight = Color(0xFFdcdcdc);
  static Color colorButtonNeutral = Color(0xFFe7e7e7);
  static Color colorButtonYes = Color(0xFF66c360);
  static Color colorButtonNo = Color(0xFFbc484a);
  // static Color colorChatNeutral = Color(0xFFc6c6c6);
  static Color colorChatNeutral = Color(0xFF999999);

  static Color colorChatSelected = Color(0xFF4eadb4);
  static Color colorChatRequired = Colors.red;

// Styles
  static TextStyle textBodyBlue10 =
      TextStyle(color: colorAudit2, fontSize: 10.0);
  static TextStyle textBodyBlue20 =
      TextStyle(color: colorAudit2, fontSize: 20.0);

  static TextStyle textBodyBlack10 =
      TextStyle(color: Colors.black, fontSize: 10.0);
  static TextStyle textBodyBlack20 =
      TextStyle(color: Colors.black, fontSize: 20.0);
  static TextStyle textBodyBlack30 =
      TextStyle(color: Colors.black, fontSize: 30.0);
  static TextStyle textBodyBlack30Poppins =
      TextStyle(color: Colors.black, fontSize: 30.0, fontFamily: 'Roboto');
  static TextStyle textBodyBlack20Poppins = TextStyle(
      color: Colors.black, fontSize: 20.0, fontFamily: 'Roboto'); //Poppins

  static TextStyle textBodyGrey20 =
      TextStyle(color: Colors.grey, fontSize: 20.0);

  static TextStyle textBodyWhite30 =
      TextStyle(color: Colors.white, fontSize: 30.0);
  static TextStyle textBodyWhite20 =
      TextStyle(color: Colors.white, fontSize: 20.0);
  static TextStyle textBodyWhiteBold20 = TextStyle(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold);
  static TextStyle textBodyWhite25 =
      TextStyle(color: Colors.white, fontSize: 25);
  static TextStyle textBodyWhite20Underlined = TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      decoration: TextDecoration.underline);
  static TextStyle textBodyWhite15 =
      TextStyle(color: Colors.white, fontSize: 15.0);
  static TextStyle textBodyWhite15Underlined = TextStyle(
      color: Colors.white,
      fontSize: 15.0,
      decoration: TextDecoration.underline);
  static TextStyle textBodyWhite10 =
      TextStyle(color: Colors.white, fontSize: 10.0);

  static TextStyle textBodyText2 =
      TextStyle(color: colorTopHeader, fontSize: 20.0);
  static TextStyle textSubtitle2 =
      TextStyle(color: colorTopHeader, fontSize: 15.0);

  static TextStyle textTransparentOffDay =
      TextStyle(color: colorTransparentOffDayText, fontSize: 42.0);

  static TextStyle textBodyBronze20 =
      TextStyle(color: colorBigDrawerBronze, fontSize: 20.0);
  static TextStyle textBodyBronze15 =
      TextStyle(color: colorBigDrawerBronze, fontSize: 15.0);

  static TextStyle textTransparent =
      TextStyle(color: Colors.transparent, fontSize: 20.0);

  static TextStyle textWhiteTerminal =
      TextStyle(color: Colors.white, fontSize: 15.0, fontFamily: 'Courier');
  static TextStyle textBlackTerminal =
      TextStyle(color: Colors.black, fontSize: 12.0, fontFamily: 'Courier');

  static TextStyle textRedScore = TextStyle(
      color: colorChatRequired,
      fontSize: 30.0,
      fontFamily: 'RobotoSlab',
      fontWeight: FontWeight.w800);
  static TextStyle textRedTest = TextStyle(
      color: colorChatRequired,
      fontSize: 15.0,
      fontFamily: 'RobotoSlab',
      fontWeight: FontWeight.w800);
  static TextStyle textOrangeScore = TextStyle(
      color: colorAudit4,
      fontSize: 30.0,
      fontFamily: 'RobotoSlab',
      fontWeight: FontWeight.w800);
  static TextStyle textGreenScore = TextStyle(
      color: colorAudit3,
      fontSize: 30.0,
      fontFamily: 'RobotoSlab',
      fontWeight: FontWeight.w800);

  static TextStyle textGreenLogoLight30 = TextStyle(
      color: colorLogoLightGreen,
      fontSize: 30.0,
      fontFamily: 'RobotoSlab',
      fontWeight: FontWeight.w800);

  static TextStyle textGreenLogoDarkBig = TextStyle(
      color: colorAnotherDarkGreen,
      fontSize: 50.0,
      // fontFamily: 'Roboto',
      fontWeight: FontWeight.w800);

  static TextStyle textGreen40 = TextStyle(
      color: colorAnotherDarkGreen,
      fontSize: 40.0,
      // fontFamily: 'Roboto',
      fontWeight: FontWeight.w600);
  static TextStyle textGreen25 = TextStyle(
      color: colorAnotherDarkGreen,
      fontSize: 25.0,
      // fontFamily: 'Roboto',
      fontWeight: FontWeight.w600);
  static TextStyle textGreen20 = TextStyle(
      color: colorAnotherDarkGreen,
      fontSize: 20.0,
      // fontFamily: 'Roboto',
      fontWeight: FontWeight.w600);
  static TextStyle textGreen35 = TextStyle(
      color: colorAnotherDarkGreen,
      fontSize: 35.0,
      // fontFamily: 'Roboto',
      fontWeight: FontWeight.w600);
  static TextStyle textGreen30 = TextStyle(
      color: colorAnotherDarkGreen,
      fontSize: 30.0,
      // fontFamily: 'Roboto',
      fontWeight: FontWeight.w600);
}
