import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laudyou_quiz/src/config/app_colors.dart';

class DisplayOperText extends StatelessWidget {
  final String text;
  double fontSize;
  double letterSpacing;

  final Color _color = const Color(0xFF376794);

  DisplayOperText(this.text,
      {Key? key, this.letterSpacing = 0, required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _displayOper(text, fontSize: fontSize);
  }

  Widget _displayOper(String text, {required double fontSize}) {
    IconData? icon;
    double paddingWidth = 10.0;
    double marginVertical = 0.0;
    double dotPadding = 0.0;
    int repeat = 1;
    if (text == "+") {
      icon = CupertinoIcons.plus;
    } else if (text == "-") {
      icon = CupertinoIcons.minus;
      fontSize = fontSize - 7;
    } else if (text == "*") {
      icon = CupertinoIcons.multiply;
    } else if (text == "=") {
      icon = CupertinoIcons.equal;
    } else if (text == "div") {
      icon = CupertinoIcons.divide;
    } else if (text == "arrow-right") {
      icon = CupertinoIcons.arrow_right;
      fontSize -= 5; // 화살표의 사이즈가 다른 아이콘보다 크다.
    } else if (text == "arrow-down") {
      icon = FontAwesomeIcons.arrowAltCircleDown;
      marginVertical = 10;
    } else if (text == "...") {
      icon = CupertinoIcons.circle_fill;
      fontSize = 8;
      repeat = 3;
      dotPadding = 3;
    } else if (text == ":") {
      icon = CupertinoIcons.ellipsis_vertical;
      dotPadding = 3;
    }

    if (fontSize > 15) {
      paddingWidth = 5;
    }

    if (text.startsWith("arrow-down-")) {
      return Container(
        child: SvgPicture.asset("assets/icons/icon_$text.svg",
            color: AppColors.iconColor1),
      );
    }

    if (icon != null) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: paddingWidth),
        margin: EdgeInsets.symmetric(vertical: marginVertical),
        child: Row(
          children: List.generate(
            repeat,
            (index) => Padding(
              padding: EdgeInsets.all(dotPadding),
              child: Text(
                String.fromCharCode(icon!.codePoint),
                style: TextStyle(
                  inherit: false,
                  color: _color,
                  fontSize: fontSize,
                  letterSpacing: letterSpacing,
                  fontWeight: FontWeight.bold,
                  fontFamily: icon.fontFamily,
                  package: icon.fontPackage,
                ),
              ),
            ),
          ).toList(),
        ),
      );
    }

    return Text(text + "oper 설정 해야 함");
  }
}
