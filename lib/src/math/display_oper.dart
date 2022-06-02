import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayOperText extends StatelessWidget {
  final String text;
  double fontSize;
  double letterSpacing;

  final Color _color = const Color(0xFF376794);

  DisplayOperText(this.text,
      {Key? key, this.letterSpacing = 40, required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _textStyle(fontSize, letterSpacing: letterSpacing),
    );
  }

  TextStyle _textStyle(double fontSize, {double letterSpacing = 0}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: _color,
      letterSpacing: letterSpacing,
    );
  }
}
