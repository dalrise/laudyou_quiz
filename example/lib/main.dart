import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:laudyou_quiz/laudyou_quiz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class Expression {
  final String name;
  final String template;
  final String expr;
  String? align;

  //Expression(this.name, this.expr);
  //Expression(this.name, this.expr);
  Expression(this.template, this.name, this.expr, this.align);
}

class _MyAppState extends State<MyApp> {
  final _controller = TextEditingController();

  final list = <Expression>[
    Expression('VERTICAL_DIVIDE', '세로 나누기',
        "divide{19}{125.78}\\spacer,1,+,3,blank{100}", null),
    Expression('HORIZONTAL_BASIC', '두수나누기',
        "4\\arrow-down-left,arrow-down-right\\,2,blank,square", null),
    Expression(
        'HORIZONTAL_BASIC',
        '두수모으기',
        "rectangle{524},blank,rectangle{4}\\arrow-down-right,arrow-down-left\\rectangle{  }",
        null),
    Expression('HORIZONTAL_BASIC', '기본1', "7,+,deco{5+5}", null),
    Expression('HORIZONTAL_BASIC', '기본2', "deco{3},+,6,+,deco{7}", null),
    Expression('HORIZONTAL_BASIC', '기본2', "deco{3},+,6,+,deco{7-1},+,9", null),
    Expression('HORIZONTAL_BASIC', '기본2', "500,+,300", null),
    Expression('HORIZONTAL_BASIC', '기본21',
        "7,frac{1}{6},=,frac{42+1}{6},=,frac{[a]}{[b]}", null),
    Expression(
        'HORIZONTAL_BASIC', '기본2', "7,frac{1}{6},circle,frac{42+1}{6}", null),
    Expression('HORIZONTAL_BASIC', '기본2', "43,*,43,=,square{a}", null),
    Expression(
        'HORIZONTAL_BASIC',
        '기본2',
        "blank,34,*,43,*,34\\arrow-right,43,*,43,=,square{a}\\=,square{b},*,34\\=,square{c}",
        "left"),
    Expression(
        'HORIZONTAL_BASIC',
        '기본2',
        "21,-,3,-,3,-,3,-,3,-,3,-,3,=,0\\spacer,arrow-down,spacer\\21,div,square{a},=,square{b}",
        null),
    // Expression('기본21',
    //     "21,-,3,-,3,-,3,-,3,-,3,-,3,=,0\\spacer,arrow-down,spacer", null),
    Expression(
        'HORIZONTAL_BASIC',
        '기본2',
        "spacer,32,-,6,-,6,-,6,-,6,-,6,=,2,spacer\\spacer,arrow-down,spacer\\31,div,square{a},=,square{b},blank,blank,blank\\spacer,...,square{c},blank,blank,blank",
        "right"),
    Expression('HORIZONTAL_BASIC', '기본2',
        "spacer,42,blank,blank,*,spacer,24,blank", null),
    Expression(
        'HORIZONTAL_BASIC', '기본2', "53,div,7,=,square\\spacer,...,24", "right"),
    Expression('HORIZONTAL_BASIC', '기본2', "6,*,16,div,{84-(31+45)}", null),
    Expression(
        'HORIZONTAL_BASIC',
        '기본2',
        "14 의 약수\\spacer,arrow-down,spacer\\\\bottomline,bottomline,bottomline,bottomline",
        null),
    Expression('HORIZONTAL_BASIC', '비례', "7.875,:,12.375", null),
  ];

  String _template = "";
  String _currentText = "";
  String? _currentAlign;

  @override
  void initState() {
    setState(() {
      _controller.text = list[0].expr;
      _currentAlign = list[0].align;
      _template = list[0].template;
      _currentText = _controller.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //_currentText = "divide{1}{124567}";
    //_currentText = "divide{1}{1}\\spacer,1,+,3,blank{100}";
    //_currentText = "divide{19}{125.78}\\spacer,1,+,3,blank{100}";
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   title: const Text('Plugin example app'),
          // ),
          body: Column(
            children: [
              Wrap(
                // alignment: WrapAlignment.start, // 정렬 방식
                // //crossAxisAlignment: WrapCrossAlignment.start,
                // direction: Axis.horizontal,
                children: List.generate(list.length, (index) {
                  return SizedBox(
                    width: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        _template = list[index].template;
                        _currentText = list[index].expr;
                        _currentAlign = list[index].align;

                        _controller.text = list[index].expr;

                        setState(() {});
                      },
                      child: Center(
                        child: Text(list[index].name),
                      ),
                    ),
                  );
                }).toList(),
              ),
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "수식을 입력해주세요",
                ),
                onChanged: (val) {
                  _currentText = val;
                  setState(() {});
                },
                validator: (val) {
                  return null;
                },
              ),
              QuizMathBasic(
                template: _template,
                expression: _currentText,
                align: _currentAlign,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
