// TODO Implement this library.import 'dart:typed_data';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';

final _whitePaint = Paint()
  ..strokeCap = StrokeCap.round
  ..color = Colors.white
  ..strokeWidth = kStrokeWidth;

final _bgPaint = Paint()..color = Colors.black;

class Recognizer {
  final Function<Future>(double, List<Offset?>) predict;
  Recognizer(this.predict);
  // static const MethodChannel opencv_channel =
  //     MethodChannel('com.laudyou.app.laudyou_app');
  //
  // Future loadModel() {
  //   LaudyouBridgeService.close();
  //
  //   return LaudyouBridgeService.loadModel(
  //     model: "assets/model.tflite",
  //     labels: "assets/labels.txt",
  //   );
  // }
  //
  // dispose() {
  //   LaudyouBridgeService.close();
  // }

  // Future processCanvasPointsV2(double canvasSize, List<Offset?> points) async {
  //   //final picture = _pointsToPicture(canvasSize, points);
  //   //Uint8List bytes = await _imageToByteListUint8(picture, kModelInputSize);
  //   Uint8List? bytes = await previewImage(canvasSize, points);
  //   //List<dynamic> classifed = await classify(binary: bytes!);
  //   return predict(bytes!!);
  // }

  Future<Uint8List?> previewImage(
      double canvasSize, List<Offset?> points) async {
    final picture = _pointsToPicture(canvasSize, points);
    final image = await picture.toImage(kModelInputSize, kModelInputSize);
    var pngBytes = await image.toByteData(format: ImageByteFormat.png);

    return pngBytes?.buffer.asUint8List();
  }

  // Future _predict(Uint8List bytes) {
  //   return predict(bytes);
  //   //return LaudyouBridgeService.runModelOnBinary(binary: bytes);
  // }

  Future<Uint8List> _imageToByteListUint8(Picture pic, int size) async {
    final img = await pic.toImage(size, size);
    final imgBytes = await img.toByteData();
    final resultBytes = Float32List(size * size);
    final buffer = Float32List.view(resultBytes.buffer);

    int index = 0;

    if (imgBytes != null) {
      for (int i = 0; i < imgBytes.lengthInBytes; i += 4) {
        final r = imgBytes.getUint8(i);
        final g = imgBytes.getUint8(i + 1);
        final b = imgBytes.getUint8(i + 2);
        buffer[index++] = (r + g + b) / 3.0 / 255.0;
      }
    }

    return resultBytes.buffer.asUint8List();
  }

  Picture _pointsToPicture(double canvasSize, List<Offset?> points) {
    final recorder = PictureRecorder();
    final canvas = Canvas(
      recorder,
      Rect.fromPoints(
        const Offset(0, 0),
        Offset(canvasSize, canvasSize),
      ),
    )..scale(kModelInputSize / canvasSize);

    canvas.drawRect(Rect.fromLTWH(0, 0, canvasSize, canvasSize), _bgPaint);

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, _whitePaint);
      }
    }

    return recorder.endRecording();
  }

  double convertPixel(int color) {
    return (255 -
            (((color >> 16) & 0xFF) * 0.299 +
                ((color >> 8) & 0xFF) * 0.587 +
                (color & 0xFF) * 0.114)) /
        255.0;
  }

  // static Future<List<dynamic>> classify({required Uint8List binary}) async {
  //   return await opencv_channel.invokeMethod(
  //     'classify',
  //     {
  //       "binary": binary,
  //     },
  //   );
  // }
}
