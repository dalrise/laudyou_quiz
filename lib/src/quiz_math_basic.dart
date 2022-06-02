import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laudyou_quiz/laudyou_quiz.dart';

import 'digit_text.dart';
import 'math/display_oper.dart';
import 'dart:math';

class QuizMathBasic extends StatelessWidget {
  final String expression;
  final String? align;
  const QuizMathBasic({
    Key? key,
    required this.expression,
    this.align,
  }) : super(key: key);

  final Color _color = const Color(0xFF376794);

  @override
  Widget build(BuildContext context) {
    final arr = expression.split('\\');

    double fontSize = _fontSize(arr);
    print('fontSize:${fontSize}');

    return Container(
      height: MediaQuery.of(context).size.height / 2,
      //width: MediaQuery.of(context).size.width,
      //constraints: BoxConstraints.expand(height: 100.0),
      //color: Colors.greenAccent,
      child: Column(
        //mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          arr.length,
          (index) {
            return _display(arr[index], fontSize);
          },
        ).toList(),
      ),
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

  Widget _displaySwitch(String text, double fontSize) {
    if (text.startsWith("deco")) {
      RegExp regexp = RegExp(r'{(.*?)}');
      String str = regexp.firstMatch(text)?[1] ?? "";
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.lightGreen,
          border: Border.all(color: _color),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Row(
            children: List.generate(str.length, (index) {
              return DigitText(
                str[index],
                fontSize: fontSize,
              );
            }).toList(),
          ),
        ),
      );
    } else if (text.startsWith("spacer")) {
      return const Spacer();
    } else if (text.startsWith("frac")) {
      /// 분모, 분자 형식으로 되어 있어서
      RegExp regexp = RegExp(r'{(.*?)}');
      Iterable<Match> matches = regexp.allMatches(text);
      final list = matches.map((m) => m[1]!).toList();
      final maxTextLength = max(list[0].length, list[1].length);

      final width = (maxTextLength * 18.0) + fontSize - 10;
      //print('maxTextLength:${maxTextLength},width:${width}');
      final top = list[0];
      final bottom = list[1];
      return Container(
        child: Column(
          children: [
            Row(
              children: List.generate(top.length,
                      (index) => DigitText(top[index], fontSize: fontSize))
                  .toList(),
            ),
            Container(
              height: fontSize / 10,
              width: width,
              decoration: BoxDecoration(
                color: _color,
                border: Border.all(color: _color),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Row(
              children: List.generate(bottom.length,
                      (index) => DigitText(bottom[index], fontSize: fontSize))
                  .toList(),
            ),
          ],
        ),
      );
    } else if (text.startsWith("circle")) {
      RegExp regexp = RegExp(r'{(.*?)}');
      String? str = regexp.firstMatch(text)?[1];
      return Container(
        width: fontSize + 10,
        height: fontSize + 10,
        //padding: EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: _color, width: 3),
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Center(child: DigitText(str ?? "", fontSize: fontSize)),
      );
    } else if (text.startsWith("square")) {
      RegExp regexp = RegExp(r'{(.*?)}');
      String? str = regexp.firstMatch(text)?[1];
      return Container(
        width: fontSize + 15,
        height: fontSize + 15,
        margin: EdgeInsets.only(bottom: fontSize / 10),
        decoration: BoxDecoration(
          border: Border.all(color: _color, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: DigitText(str ?? "", fontSize: fontSize)),
      );
    } else if (text.startsWith("blank")) {
      RegExp regexp = RegExp(r'{(.*?)}');
      double number = fontSize;
      if (regexp.firstMatch(text)?[1] != null) {
        number = double.parse(regexp.firstMatch(text)?[1] ?? '0');
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: number,
        height: number,
        child: Text("", style: TextStyle(fontSize: fontSize)),
      );
    } else if (_isOperation(text)) {
      return DisplayOperText(text, fontSize: fontSize);
    } else if (text.startsWith("bottomline")) {
      RegExp regexp = RegExp(r'{(.*?)}');
      String? str = regexp.firstMatch(text)?[1];
      double number = fontSize + 2;
      return Container(
        width: number,
        height: number,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _color,
              width: 3.0,
            ),
          ),
          //borderRadius: BorderRadius.circular(5),
        ),
        child: Center(child: Text(str ?? "")),
      );
    }

    return Row(
      children: List.generate(text.length, (index) {
        return DigitText(text[index], fontSize: fontSize);
      }),
    );

    //return DigitText(text, fontSize: fontSize);
  }

  double _fontSize(List<String> list) {
    final itemSizeList = list.map((str) {
      final arr = str.split(',');
      int itemSize = 0;

      itemSize = arr.map(
        (s) {
          if (s.startsWith("deco") || s.startsWith("frac")) {
            // 분자와 분모중 큰 사이즈를 반환
            RegExp regexp = RegExp(r'{(.*?)}');
            final matches = regexp.allMatches(s);
            final list = matches.map((m) => m[1]!).toList();

            // 1 값을 더해서 폰트 사이즈를 더 적게 처리
            if (list.length == 1) {
              return list[0].length;
            }
            //return 0.0;
            // print(list[0] +
            //     "," +
            //     list[1] +
            //     "=" +
            //     max(list[0].length + 1, list[1].length).toString());
            return max(list[0].length, list[1].length);
          } else if (s == "circle" || s.startsWith("square")) {
            return 2;
          } else if (s == "rightarrow" ||
              s == "downarrow" ||
              s == "bottomline" ||
              s.startsWith("blank") ||
              s.startsWith("spacer")) {
            return 1;
          }

          s = s.replaceAll(RegExp(r'[{|}|(|)]'), "");

          return s.length;
        },
      ).reduce((value, element) => value + element);

      return itemSize;
    }).toList();

    int itemSizeMax = itemSizeList.reduce(max);

    double fontSize = 20;
    print('itemSizeMax:$itemSizeMax');
    if (itemSizeMax == 4) {
      fontSize = 90;
    } else if (itemSizeMax == 5) {
      fontSize = 80;
    } else if (itemSizeMax == 7) {
      fontSize = 60;
    } else if (itemSizeMax == 8) {
      fontSize = 55;
    } else if (itemSizeMax == 9) {
      fontSize = 45;
    } else if (itemSizeMax == 14) {
      fontSize = 27;
    } else if (itemSizeMax == 15) {
      fontSize = 25;
    } else if (itemSizeMax > 15) {
      fontSize = 23;
    }

    print('itemSizeMax:${itemSizeMax}, fontSize:$fontSize');

    return fontSize;
  }

  Widget _display(String str, double fontSize) {
    final arr = str.split(',');
    return Container(
      padding: EdgeInsets.all(8),
      // decoration: BoxDecoration(
      //   color: Colors.amberAccent,
      // ),
      child: Row(
        mainAxisAlignment: align == "left"
            ? MainAxisAlignment.start
            : align == "right"
                ? MainAxisAlignment.end
                : MainAxisAlignment.center,
        children: List.generate(
          arr.length,
          (index) {
            final text = arr[index];
            return _displaySwitch(text, fontSize);
          },
        ).toList(),
      ),
    );
  }

  bool _isOperation(String text) {
    return text == "+" ||
        text == "-" ||
        text == "=" ||
        text == "*" ||
        text == "div" ||
        text == "..." ||
        text == "rightarrow" ||
        text == "downarrow";
  }

  Widget _displayIcons(String text, double fontSize) {
    //print("_displayIcons:${text}");
    if (text.startsWith("rightarrow")) {
      return Icon(CupertinoIcons.arrow_right, size: fontSize);
    }
    if (text.startsWith("downarrow")) {
      RegExp regexp = RegExp(r'{(.*?)}');
      String? str = regexp.firstMatch(text)?[1];
      print(str);
      //if (str == "center") {
      return Expanded(
        child: Align(
          alignment: str == "center" ? Alignment.center : Alignment.topLeft,
          child: Icon(CupertinoIcons.arrow_down),
        ),
      );
      // }
    }
    return Text(text + "_displayIcons");
  }
}
