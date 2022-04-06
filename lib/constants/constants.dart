// ignore_for_file: non_constant_identifier_names

// import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

const primary = Color(0xff292929);
const lightPrimary = Color(0xff383434);
const secondary = Color(0xff3372b1);

const bottomNavUnselect = Color(0xffededf3);

const primaryText = Color(0xfff4f4f5);
const secondaryText = Color.fromARGB(255, 157, 157, 165);

const white = Colors.white;
const black = Colors.black;
const grey = Color.fromRGBO(0, 0, 0, .6);

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

showSnackBar(BuildContext context, String text, {Color color = secondary}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      elevation: 3,
      content: Text(text, textAlign: TextAlign.center),
    ),
  );
}

class StarDisplayWidget extends StatelessWidget {
  final int value;
  final Widget filledStar;
  final Widget unfilledStar;
  const StarDisplayWidget({
    Key? key,
    this.value = 0,
    required this.filledStar,
    required this.unfilledStar,
  })  : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return index < value ? filledStar : unfilledStar;
      }),
    );
  }
}

class StarDisplay extends StarDisplayWidget {
  const StarDisplay({Key? key, int value = 0})
      : super(
          key: key,
          value: value,
          filledStar: const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          unfilledStar: const Icon(
            Icons.star_border,
            color: Colors.amber,
          ),
        );
}
