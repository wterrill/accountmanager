// ignore_for_file: file_names
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: parameter_assignments
import 'package:flutter/material.dart';

Widget FlatButtonX(
    {Color? colorx,
    required Widget childx,
    RoundedRectangleBorder? shapex,
    required Function? onPressedx,
    Key? keyx,
    Color? disabledColorx,
    Color? disabledTextColorx,
    Color? textColorx}) {
  if (disabledTextColorx == null && textColorx == null) {
    disabledTextColorx = colorx;
  }
  textColorx ??= colorx;
  return TextButton(
      key: keyx,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          // text color
          (states) => states.contains(MaterialState.disabled)
              ? disabledTextColorx
              : textColorx,
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          // background color    this is color:
          (states) =>
              states.contains(MaterialState.disabled) ? disabledColorx : colorx,
        ),
        shape: MaterialStateProperty.all(shapex),
      ),
      onPressed: onPressedx as void Function()?,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0), child: childx));
}

Widget RaisedButtonX(
    {Color? colorx,
    required Widget childx,
    RoundedRectangleBorder? shapex,
    required Function? onPressedx,
    Key? keyx,
    Color? disabledColorx,
    Color? disabledTextColorx,
    Color? textColorx}) {
  if (disabledTextColorx == null && textColorx == null) {
    disabledTextColorx = colorx;
  }
  // if (textColorx == null) {
  //   textColorx = colorx;
  // }
  textColorx ??= colorx;
  return ElevatedButton(
      key: keyx,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          // text color
          (states) => states.contains(MaterialState.disabled)
              ? disabledTextColorx
              : textColorx,
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          // background color    this is color:
          (states) =>
              states.contains(MaterialState.disabled) ? disabledColorx : colorx,
        ),
        shape: MaterialStateProperty.all(shapex),
      ),
      onPressed: onPressedx as void Function()?,
      child: childx);
}
