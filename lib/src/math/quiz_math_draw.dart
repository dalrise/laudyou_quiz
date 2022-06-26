import 'package:flutter/cupertino.dart';

import '../ocr/draw_ocr_predict_model.dart';
import '../ocr/draw_ocr_widget.dart';

/// ocr 영역 처리
class QuizMathDraw extends StatelessWidget {
  //final String question;
  //final String answer;
  //final VoidCallback onAnswerCorrect;
  /// ocr 처리 결과 리턴 함수
  final ValueChanged<DrawOcrPredictModel> onPredict;


  final String? maskingText;
  final double width;
  final double height;
  final int ocrIndex; // 화면에 표시되는 ocr index 번호

  //final Function<Future>(double, List<Offset?>) predict;
  final Function(double, List<Offset?>) predict;
  final Function() loadModel;
  final Function() close;

  //List<Offset?> points = [];
  final List<Offset?> ocrPoints;
  //List<Offset?> ocrPoints2 = []; // 2번째 ocr input 용
  //Map<int, String> answerMap = {};

  QuizMathDraw({
    Key? key,
    //required this.question,
    //required this.answer,
    //required this.onAnswerCorrect,
    required this.ocrIndex,
    required this.onPredict,
    this.maskingText,
    required this.width,
    this.height = 150.0,
    required this.predict,
    required this.ocrPoints,
    required this.loadModel,
    required this.close,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawOcrWidget(
      ocrIndex: ocrIndex,
      points: ocrPoints,
      width: width,
      height: height,
      maskingText: maskingText,
      strokeWidth: 10.0,
      predict: predict,
      loadModel: loadModel,
      close: close,
      onPredict: onPredict,
      //onPredict: _ocrPredict,
    );
  }

  /*
  _ocrPredict(DrawOcrPredictModel data) {
    //print("onPredict:" + data.toString());
    String? remain =
        answer.split(",").firstWhereOrNull2((element) => element == "...");

    answerMap[data.ocrIndex] = data.value;
    if (remain != null && data.ocrIndex == 2) {
      answerMap[2] = "...";
      answerMap[data.ocrIndex + 1] = data.value;
    }

    final result = answerMap.entries.map((e) => e.value).toList().join(",");
    print("onPredict.result:$result, answer:$answer");

    //print(ocrPoints.length);
    if (answer == result) {
      points.clear();
      ocrPoints1.clear();
      ocrPoints2.clear();
      answerMap.clear();

      onAnswerCorrect();
    }
  }

   */
}

extension FirstWhereExt<T> on List<T> {
  T? firstWhereOrNull2(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
