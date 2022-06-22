import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laudyou_quiz/laudyou_quiz.dart';

void main() {
  runApp(const MainDraw());
}

class MainDraw extends StatelessWidget {
  const MainDraw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final f = processCanvasPointsV2;
    print(f);
    //return Container();
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: QuizMathDraw(
            loadModel: loadModel,
            predict: processCanvasPointsV2,
            //onAnswerCorrect: () {},
            width: 100,
            close: () {
              print("close");
            },
            //answer: '11',
            onPredict: (DrawOcrPredictModel value) {}, ocrIndex: 0,
            //question: '1,+,2',
          ),
        ),
      ),
    );
  }

  Future loadModel() async {
    print("loadModel!!");
    await Future.delayed(const Duration(minutes: 1));
  }

  Future processCanvasPointsV2(double canvasSize, List<Offset?> points) async {
    print("processCanvasPointsV2");
    await Future.delayed(const Duration(minutes: 1));

    //final picture = _pointsToPicture(canvasSize, points);
    //Uint8List bytes = await _imageToByteListUint8(picture, kModelInputSize);
    // Uint8List? bytes = await previewImage(canvasSize, points);
    // //List<dynamic> classifed = await classify(binary: bytes!);
    // return _predict(bytes!);
  }
}
