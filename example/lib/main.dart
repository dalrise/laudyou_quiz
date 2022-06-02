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

  Expression(this.name, this.expr);
}

class _MyAppState extends State<MyApp> {
  final _controller = TextEditingController();

  final list = <Expression>[
    Expression('기본1', "7,+,deco{5+5}"),
    Expression('기본2', "deco{3},+,6,+,deco{7}"),
    Expression('기본2', "deco{3},+,6,+,deco{7-1},+,9"),
    Expression('기본2', "500,+,300"),
    Expression('기본2', "7,frac{1}{6},=,frac{42+1}{6},=,frac{a}{b}"),
    Expression('기본2', "7,frac{1}{6},circle,frac{42+1}{6}"),
    Expression('기본2', "43,*,43,=,square{a}"),
    Expression('기본2',
        "34,X,43,X,34\\rightarrow,43,*,43,=,square{a}\\=,square{b},*,34\\=,square{c}"),
  ];

  String _currentText = "";

  @override
  void initState() {
    setState(() {
      _controller.text = list[0].expr;
      _currentText = _controller.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
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
            ),
          ],
        ),
      ),
    );
  }
}
