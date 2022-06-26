import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../dimensions.dart';
import 'digit_text.dart';

class MathVerticalDivide extends StatelessWidget {
  const MathVerticalDivide({
    Key? key,
    required this.arr,
    required this.fontSize,
  }) : super(key: key);

  final List<String> arr;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    //print(150.0 * arr[1].length);
    double padding_top_line = 10.0 - arr.join('').length;
    double width = 150.0 + (fontSize * 0.40 * (arr[1].length - 1));
    double left = 50 - (fontSize * 0.1 * (arr[1].length - 1));
    double height_top_line = 13.0 - (log(fontSize) * 0.6 * (arr[1].length - 1));
    print(height_top_line);
    if (height_top_line < 5) {
      height_top_line = 5;
    }

    return Container(
      //color: Colors.green,
      //width: 350,
      //padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          // 맨위 box : 몫
          //_boxList(arr[3], valueSize: arr[0].length),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                //color: Colors.red,
                padding: EdgeInsets.only(top: padding_top_line, left: 10),
                child: DigitText(
                  arr[0],
                  letterSpacing: 0,
                  fontSize: fontSize,
                ),
              ),
              Stack(
                children: [
                  Container(
                    //key: const ValueKey(0),
                    //color: Colors.yellow,
                    //width: 70.0 + (35 * (arr[1].length - 1)),
                    /// 여기사이즈에 따라 오른쪽의 길이가 결정 된다.
                    width: width,
                    padding: EdgeInsets.only(top: padding_top_line, left: left),
                    child: DigitText(
                      arr[1],
                      // 3자리면 screen overflow 발생
                      letterSpacing: 3, // arr[0].length == 3 ? 10 : 40,
                      fontSize: fontSize,
                    ),
                  ),
                  Positioned(
                    top: -5,
                    child: DigitText(
                      ")",
                      letterSpacing: 0,
                      fontSize: fontSize,
                    ),
                  ),

                  /// 나눗셈 위 라인
                  Positioned(
                    top: padding_top_line,
                    left: 3,
                    child: Container(
                      height: height_top_line,
                      width: width - 10,
                      decoration: BoxDecoration(
                        color: const Color(0xFF376794),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                ],
              ),
              //SizedBox(width: 30),
            ],
          ),
          // 나누는 값, 바깥쪽 괄호, 위의 line, 원값
          // box1
          //..._fotterBoxList(listBox: arrBox, valueSize: arr[0].length),
        ],
      ),
    );
  }

  // Widget _boxList(String text, {required int valueSize}) {
  //   int boxCount = int.parse(text.replaceAll("box", ""));
  //   double boxWidth = valueSize == 3 ? 90 * 2 : 90;
  //   if (valueSize == 3 || valueSize == 1) {
  //     // 나누는 값이 1, 3 자리면 box1, box2 에 상관 없이 1로 설정
  //     boxCount = 1;
  //   }
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.end,
  //     children: [
  //       ...List.generate(boxCount, (index) => _boxMake(boxWidth)),
  //       //...List.generate(boxCount, (index) => List.generate(boxCount, (index) => _boxMake(10)),),
  //       SizedBox(width: 30),
  //     ],
  //   );
  // }

  // Widget _boxMake(double width) {
  //   return Container(
  //     width: width,
  //     height: 90,
  //     margin: const EdgeInsets.only(left: 5, bottom: 5),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10),
  //       border: Border.all(color: Colors.blue),
  //     ),
  //   );
  // }
  //
  // List<Widget> _fotterBoxList(
  //     {required List<String> listBox, required int valueSize}) {
  //   //print("valueSize:$valueSize");
  //   //print("valueSize:${110.0 * valueSize - 1}");
  //   double lineWidth = valueSize == 3 ? 230 : 110.0 * (valueSize);
  //   return List.generate(
  //     listBox.length,
  //     (index) => Container(
  //       child: index < listBox.length - 1
  //           ? _boxList(listBox[index], valueSize: valueSize)
  //           : Column(
  //               children: [
  //                 Align(
  //                   alignment: Alignment.topRight,
  //                   child: Container(
  //                     height: 7.0,
  //                     width: lineWidth,
  //                     margin:
  //                         EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //                 _boxList(listBox[index], valueSize: valueSize)
  //               ],
  //             ),
  //     ),
  //   );
  // }
}
