import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayOperText extends StatelessWidget {
  final String text;
  double fontSize;
  double letterSpacing;

  final Color _color = const Color(0xFF376794);

  DisplayOperText(this.text,
      {Key? key, this.letterSpacing = 10, required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _displayOper(text, fontSize: fontSize);
  }

  Widget _displayOper(String text, {required double fontSize}) {
    if (text == "+") {
      // return Icon(
      //   CupertinoIcons.plus,
      //   size: 60,
      //   color: Colors.lightGreen,
      // );
      return Container(
        //padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          String.fromCharCode(CupertinoIcons.plus.codePoint),
          style: TextStyle(
            inherit: false,
            color: _color,
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            fontWeight: FontWeight.bold,
            fontFamily: CupertinoIcons.plus.fontFamily,
            package: CupertinoIcons.plus.fontPackage,
          ),
        ),
      );
    } else if (text == "-") {
      // return Icon(
      //   CupertinoIcons.plus,
      //   size: 60,
      //   color: Colors.lightGreen,
      // );
      return Container(
        // padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          String.fromCharCode(CupertinoIcons.minus.codePoint),
          style: TextStyle(
            inherit: false,
            color: _color,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            fontFamily: CupertinoIcons.minus.fontFamily,
            package: CupertinoIcons.minus.fontPackage,
          ),
        ),
      );
    }
    if (text == "div") {
      return const Icon(CupertinoIcons.divide);
    }
    return Text(text + "_displayOper");
  }
}
