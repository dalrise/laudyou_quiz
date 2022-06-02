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
  final String expr;
  String? align;

  //Expression(this.name, this.expr);
  //Expression(this.name, this.expr);
  Expression(this.name, this.expr, this.align);
}

class _MyAppState extends State<MyApp> {
  final _controller = TextEditingController();

  final list = <Expression>[
    Expression('기본1', "7,+,deco{5+5}", null),
    Expression('기본2', "deco{3},+,6,+,deco{7}", null),
    Expression('기본2', "deco{3},+,6,+,deco{7-1},+,9", null),
    Expression('기본2', "500,+,300", null),
    Expression('기본2', "7,frac{1}{6},=,frac{42+1}{6},=,frac{a}{b}", null),
    Expression('기본2', "7,frac{1}{6},circle,frac{42+1}{6}", null),
    Expression('기본2', "43,*,43,=,square{a}", null),
    Expression(
        '기본2',
        "blank,34,*,43,*,34\\rightarrow,43,*,43,=,square{a}\\=,square{b},*,34\\=,square{c}",
        "left"),
    Expression(
        '기본2',
        "21,-,3,-,3,-,3,-,3,-,3,-,3,=,0\\spacer,downarrow,spacer\\21,div,square{a},=,square{b}",
        null),
    // Expression('기본21',
    //     "21,-,3,-,3,-,3,-,3,-,3,-,3,=,0\\spacer,downarrow,spacer", null),
    Expression(
        '기본2',
        "spacer,32,-,6,-,6,-,6,-,6,-,6,=,2,spacer\\spacer,downarrow,spacer\\31,div,square{a},=,square{b},blank,blank,blank\\spacer,...,square{c},blank,blank,blank",
        "right"),
    Expression('기본2', "spacer,42\\*,spacer,24", null),
    Expression('기본2', "53,div,7,=,square\\spacer,...,24", "right"),
    Expression('기본2', "6,*,16,div,{84-(31+45)}", null),
    Expression(
        '기본2',
        "14 의 약수\\spacer,downarrow,spacer\\\\bottomline,bottomline,bottomline,bottomline",
        null),
  ];

  String _currentText = "";
  String? _currentAlign;

  @override
  void initState() {
    setState(() {
      _controller.text = list[0].expr;
      _currentAlign = list[0].align;
      _currentText = _controller.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
