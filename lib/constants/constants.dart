// ignore_for_file: non_constant_identifier_names

// import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

const primaryColor = Color(0xff032541);
const secondaryColor = Color(0xff01b4e4);

const whiteColor = Colors.white;
const blackColor = Colors.black;
const greyColor = Color.fromRGBO(0, 0, 0, .6);

const unselectedItem = Color.fromARGB(255, 189, 189, 189);

Widget AppText(
    {FontWeight isBold = FontWeight.normal,
    Color color = blackColor,
    required double size,
    required String text,
    int maxLines = 0,
    bool overflow = false,
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
    ),
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
