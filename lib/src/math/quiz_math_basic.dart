import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../dimensions.dart';
import 'components/digit_text.dart';
import './components/display_oper.dart';

class QuizMathBasic extends StatelessWidget {
  final String expression;
  final String? align;
  // final double? width;
  // final double? height;
  final double? fontSize;
  const QuizMathBasic({
    Key? key,
    required this.expression,
    this.align,
    // this.width,
    // this.height,
    this.fontSize, // 호출자에서 fontSize 값을 호출하면 fontSize 를 고정한다.
  }) : super(key: key);

  final Color _color = const Color(0xFF376794);

  @override
  Widget build(BuildContext context) {
    final arr = expression.split('\\');

    //print();
    // final calcWidth = width ?? MediaQuery.of(context).size.width;
    // print(Dimensions(context).font20);

    double _fontSize = fontSize ?? _fontSizeByLine(arr, context);
    //_fontSize += Dimensions(context).font14;
    //fontSize = 12;
    //print('fontSize:${_fontSize}');
    // fontSize = fontSize / (calcWidth / 20);
    // print('fontSize:${fontSize}');

    return Container(
      // width: width,
      // height: height ?? MediaQuery.of(context).size.height / 2,
      //width: MediaQuery.of(context).size.width,
      //constraints: BoxConstraints.expand(height: 100.0),
      //color: Colors.greenAccent,
      padding: EdgeInsets.only(
          top: fontSize == null ? MediaQuery.of(context).size.height / 20 : 0),
      child: Column(
        //mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          arr.length,
          (index) {
            return _display(arr[index], _fontSize);
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

      final width = (maxTextLength * 18.0) + fontSize - 20;
      //print('maxTextLength:${maxTextLength},width:${width}');
      final top = list[0];
      final bottom = list[1];
      //print(top);
      return Container(
        child: Column(
          children: [
            top.startsWith("[") && top.endsWith("]")
                ? _makeSquare(top.replaceAll(RegExp(r'[\[|\]]'), ""), fontSize)
                : Row(
                    children: List.generate(
                        top.length,
                        (index) =>
                            DigitText(top[index], fontSize: fontSize)).toList(),
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
            bottom.startsWith("[") && bottom.endsWith("]")
                ? _makeSquare(
                    bottom.replaceAll(RegExp(r'[\[|\]]'), ""), fontSize)
                : Row(
                    children: List.generate(
                            bottom.length,
                            (index) =>
                                DigitText(bottom[index], fontSize: fontSize))
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
      return _makeSquare(str, fontSize);
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
      double number = fontSize;
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
        return Padding(
          padding: const EdgeInsets.only(right: 2.0),
          child: DigitText(text[index], fontSize: fontSize),
        );
      }),
    );

    //return DigitText(text, fontSize: fontSize);
  }

  Widget _makeSquare(String? str, double fontSize) {
    return Container(
      width: fontSize + 15,
      height: fontSize + 15,
      margin: EdgeInsets.only(top: fontSize / 10, bottom: fontSize / 10),
      decoration: BoxDecoration(
        border: Border.all(color: _color, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: DigitText(str ?? "", fontSize: fontSize)),
    );
  }

  double _fontSizeByLine(List<String> list, BuildContext context) {
    final itemSizeList = list.map((str) {
      final arr = str.split(',');
      double itemSize = 0.0;

      itemSize = arr.map(
        (s) {
          if (s.startsWith("deco") || s.startsWith("frac")) {
            // 분자와 분모중 큰 사이즈를 반환
            RegExp regexp = RegExp(r'{(.*?)}');
            final matches = regexp.allMatches(s);
            final list = matches.map((m) => m[1]!).toList();

            // 1 값을 더해서 폰트 사이즈를 더 적게 처리
            if (list.length == 1) {
              return list[0].length * 1.0;
            }
            //return 0.0;
            // print(list[0] +
            //     "," +
            //     list[1] +
            //     "=" +
            //     max(list[0].length + 1, list[1].length).toString());
            //print(list);
            return max(list[0].length * 1.0, list[1].length * 1.0) + 0.5;
            //return max(list[0].length * 1.0, list[1].length * 1.0);
          } else if (s == " ") {
            return 0.5;
          } else if (s == "circle" || s.startsWith("square")) {
            return 1.5;
          } else if (s == "rightarrow" ||
              s == "downarrow" ||
              s == "bottomline" ||
              s.startsWith("blank") ||
              s.startsWith("spacer")) {
            return 1.0;
          } else if (s == "+" || s == "-" || s == "*" || s == "=" || s == ":") {
            return 1.2;
          }

          s = s.replaceAll(RegExp(r'[{|}|(|)]'), "");

          return s.length * 1.0;
        },
      ).reduce((value, element) => value + element);

      return itemSize;
    }).toList();

    double itemSizeMax = itemSizeList.reduce(max);

    // final aa = [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17].map((e) {
    //   return 100 - (e * 4.5) + 20;
    // }).toList();
    // print(aa);

    //double fontSize = 100 - (itemSizeMax * 7.5) + 20;
    //print('itemSizeMax:$itemSizeMax');
    // 아직 규칙을 잡을 수 없어서 하나씩 확인
    double fontSize = Dimensions(context).font24; //25;

    if (itemSizeMax >= 19) {
      fontSize = Dimensions(context).font24;
    } else if (itemSizeMax >= 17) {
      fontSize = Dimensions(context).font24 + 2;
    } else if (itemSizeMax >= 16) {
      fontSize = Dimensions(context).font27;
    } else if (itemSizeMax >= 15) {
      fontSize = Dimensions(context).font30 + 2; //32;
    } else if (itemSizeMax >= 14) {
      fontSize = Dimensions(context).font30; //27;
    } else if (itemSizeMax >= 13) {
      fontSize = Dimensions(context).font30; //30;
    } else if (itemSizeMax >= 12) {
      fontSize = Dimensions(context).font45; //45;
    } else if (itemSizeMax >= 11) {
      fontSize = Dimensions(context).font45 + 3; //48;
    } else if (itemSizeMax >= 10) {
      fontSize = Dimensions(context).font50; //50;
    } else if (itemSizeMax >= 9) {
      fontSize = Dimensions(context).font50; //50;
    } else if (itemSizeMax >= 8) {
      fontSize = Dimensions(context).font50 + 10; //60;
    } else if (itemSizeMax >= 7) {
      fontSize = Dimensions(context).font50 + 20; //70;
    } else if (itemSizeMax >= 5) {
      fontSize = Dimensions(context).font50 + 30; //80;
    } else if (itemSizeMax >= 4) {
      fontSize = Dimensions(context).font90 + 20; // 110;
    }

    //print('itemSizeMax:${itemSizeMax}, fontSize:$fontSize');

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
        text == ":" ||
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
