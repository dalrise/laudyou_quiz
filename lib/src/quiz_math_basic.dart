import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laudyou_quiz/laudyou_quiz.dart';

import 'digit_text.dart';
import 'math/display_oper.dart';

class QuizMathBasic extends StatelessWidget {
  final String expression;
  const QuizMathBasic({Key? key, required this.expression}) : super(key: key);

  final Color _color = const Color(0xFF376794);

  @override
  Widget build(BuildContext context) {
    final arr = expression.split('\\');

    return Container(
      height: MediaQuery.of(context).size.height / 3,
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
            return _display(arr[index]);
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

  /// +, -, /, *

  Widget _displayIcons(String text) {
    if (text.startsWith("rightarrow")) {
      return Icon(CupertinoIcons.arrow_right);
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

  bool isOperation(String text) {
    return text == "+" || text == "-" || text == "*" || text == "div";
  }

  Widget _displaySwitch(String text, double fontSize) {
    if (isOperation(text)) {
      return DisplayOperText(text, fontSize: fontSize);
    } else if (text == "rightarrow" || text == "downarrow" || text == "-") {
      return _displayIcons(text);
    } else if (text.startsWith("deco")) {
      RegExp regexp = RegExp(r'{(.*?)}');
      String str = regexp.firstMatch(text)?[1] ?? "";
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.lightGreen,
          border: Border.all(color: Color(0xFFF66512)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Row(
            children: List.generate(str.length, (index) {
              print(str[index]);
              if (isOperation(str[index])) {
                return DisplayOperText(str[index], fontSize: fontSize);
              } else {
                return DigitText(
                  str[index],
                  fontSize: fontSize,
                );
              }
            }).toList(),
          ),
        ),
      );
    }
    return DigitText(text, fontSize: fontSize);
  }

  Widget _display(String str) {
    final arr = str.split(',');
    int itemSize = 0;

    print(str);
    RegExp regexp = RegExp(r'\d+');
    Iterable<Match> matches = regexp.allMatches(str);
    itemSize = matches.length;
    // 수식 개수
    RegExp regexpOper = RegExp(r'[\+|\-|\*]');
    Iterable<Match> matchesOper = regexpOper.allMatches(str);
    itemSize += matchesOper.length;

    double fontSize = 30;
    if (itemSize == 5) {
      fontSize = 90;
    } else if (itemSize == 9) {
      fontSize = 50;
    }

    print('itemSize:${itemSize}, fontSize:$fontSize');

    return Container(
      // decoration: BoxDecoration(
      //   color: Colors.amberAccent,
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          arr.length,
          (index) {
            final text = arr[index];

            return _displaySwitch(text, fontSize);

            if (text.startsWith("spacer")) {
              return Spacer();
            }

            if (text.startsWith("blank")) {
              RegExp regexp = RegExp(r'{(.*?)}');
              final number = double.parse(regexp.firstMatch(text)?[1] ?? '20');
              return Container(
                width: number,
                height: number,
              );
            }

            if (text.startsWith("circle")) {
              RegExp regexp = RegExp(r'{(.*?)}');
              String? str = regexp.firstMatch(text)?[1];
              return Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(child: Text(str ?? "")),
              );
            }

            if (text.startsWith("bottomline")) {
              RegExp regexp = RegExp(r'{(.*?)}');
              String? str = regexp.firstMatch(text)?[1];
              return Container(
                width: 50,
                height: 2,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      //                   <--- left side
                      color: Colors.black,
                      width: 3.0,
                    ),
                  ),
                  //borderRadius: BorderRadius.circular(5),
                ),
                child: Center(child: Text(str ?? "")),
              );
            }

            if (text.startsWith("square")) {
              RegExp regexp = RegExp(r'{(.*?)}');
              String? str = regexp.firstMatch(text)?[1];
              return Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text(str ?? "")),
              );
            }

            if (text.startsWith("frac")) {
              /// 분모, 분자 형식으로 되어 있어서
              RegExp regexp = RegExp(r'{(.*?)}');
              Iterable<Match> matches = regexp.allMatches(text);
              final list = matches.map((m) => m[1]!).toList();
              return Container(
                child: Column(
                  children: [
                    Text(list[0]),
                    Container(
                      height: 2,
                      width: 30,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.pink,
                      )),
                    ),
                    Text(list[1]),
                  ],
                ),
              );
            }

            return Text(
              arr[index],
              style: _textStyle(fontSize),
            );
          },
        ).toList(),
        // children: [
        //
        //   Text("7"),
        //   Text("+"),

        // ],
      ),
    );
  }
}
