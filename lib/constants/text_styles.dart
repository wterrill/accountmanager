import 'package:flutter/material.dart';

// ignore_for_file: avoid_classes_with_only_static_members

class ColorDefs {
  static const Color colorBigDrawerBronze = Color(0xFFA36422);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color green = Colors.green;
  static const Color disabled = Color(0xFFB0B7BC);

  // for shapes
  static Color redOpacity80 = Colors.red.withOpacity(0.8);
}

class TextStyles {
  static const TextStyle heading1 =
      TextStyle(fontSize: 38, color: ColorDefs.black);
  static TextStyle heading2 = TextStyle(fontSize: 28, color: Colors.blue[800]);
  static const TextStyle button1White =
      TextStyle(fontSize: 18, color: ColorDefs.white);

  static TextStyle heading3 = TextStyle(fontSize: 18, color: Colors.blue[800]);
  static TextStyle heading4 = const TextStyle(fontSize: 12, color: Colors.blue);
  static const TextStyle textBodyBronze20 =
      TextStyle(color: ColorDefs.colorBigDrawerBronze, fontSize: 20.0);
}

class ShapeStyle {
  static RoundedRectangleBorder redRoundedBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(9.0),
    side: BorderSide(
      color: ColorDefs.redOpacity80,
      width: 1,
    ),
  );

  static RoundedRectangleBorder noColorRoundedBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25.0),
  );
}

class PaddingStyles {
  static const EdgeInsets primaryButtonPadding =
      EdgeInsets.fromLTRB(16.8, 8.0, 16.0, 8.0);
}
