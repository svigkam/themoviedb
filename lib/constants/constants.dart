// ignore_for_file: non_constant_identifier_names

// import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';


const background = Color(0xff2f2e3e);
const purple = Color(0xffac55ff);

const primaryColorRed = Color(0xFFda1a37);
const secondaryColorRed = Color(0xFF1a1a2c);

const bottomNavColor = Color(0xff414256);
const bottomNavSelect = Color(0xffac5cd3);
const bottomNavUnselect = Color(0xffededf3);

const primaryText = Color(0xfff4f4f5);
const secondaryText = Color(0xff8d8ba1);

const primaryColor = Color(0xff032541);
const secondaryColor = Color(0xff01b4e4);

const whiteColor = Colors.white;
const blackColor = Colors.black;
const greyColor = Color.fromRGBO(0, 0, 0, .6);

Widget AppText(
    {FontWeight isBold = FontWeight.normal,
    Color color = primaryText,
    required double size,
    required String text,
    int maxLines = 0,
    bool overflow = false,
    bool lineThrough = false,
    bool alignCenter = false}) {
  return Text(
    text,
    textAlign: alignCenter == true ? TextAlign.center : null,
    maxLines: maxLines == 0 ? null : maxLines,
    overflow: overflow == true ? TextOverflow.ellipsis : null,
    style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: isBold,
        decoration: lineThrough ? TextDecoration.lineThrough : null),
  );
}

showSnackBar(BuildContext context, String text, {Color color = primaryColor}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      elevation: 3,
      content: Text(text, textAlign: TextAlign.center),
    ),
  );
}
