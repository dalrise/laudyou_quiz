import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config/app_colors.dart';
import 'constants.dart';
import 'drawing_painter.dart';
import 'recognizer.dart';
import 'draw_ocr_predict_model.dart';
import 'prediction.dart';

class DrawOcrWidget extends StatefulWidget {
  const DrawOcrWidget(
      {Key? key,
      required this.predict,
      required this.onPredict,
      required this.loadModel,
      required this.close,
      this.width = 200,
      this.height = 200,
      this.backgroundColor = Colors.white,
      this.strokeWidth = 5.0,
      required this.points,
      this.ocrIndex = 1})
      : super(key: key);

  final int ocrIndex; // 화면에 표시되는 ocr index 번호
  final Function() loadModel;
  final Function() close;
  final Function(double, List<Offset?>) predict;
  final ValueChanged<DrawOcrPredictModel> onPredict;
  final double width;
  final double height;
  final Color backgroundColor;
  final double strokeWidth; // 두께

  final List<Offset?> points;

  @override
  _DrawOcrWidget createState() => _DrawOcrWidget();
}

class _DrawOcrWidget extends State<DrawOcrWidget> {
  //final Recognizer _recognizer = Recognizer(widget.predict);
  String predictLabel = "";
  List<Prediction>? _prediction;
  Paint? drawingPaint;

  //List<Offset?> points = [];

  void cleanDrawing() {
    setState(() {
      widget.points.clear();
      _prediction?.clear();
      predictLabel = "";
    });
  }

  void _initModel() async {
    await widget.loadModel();
  }

  void _digitPredictions() async {
    String nums = await widget.predict(widget.width, widget.points);
    //print(predictions);
    print("widget.ocrIndex:${widget.ocrIndex}");
    setState(() {
      if (nums != null) {
        predictLabel = nums;
        widget.onPredict(
          DrawOcrPredictModel(
            value: predictLabel,
            ocrIndex: widget.ocrIndex,
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initModel();

    // if (widget.points != null) {
    //   print("widget.points: 초기화");
    //   points = widget.points!;
    // }

    drawingPaint = Paint()
      ..strokeCap = StrokeCap.square
      ..isAntiAlias = kIsAntiAlias
      ..color = kBrushBlack
      ..strokeWidth = widget.strokeWidth;
  }

  @override
  Widget build(BuildContext context) {
    //print("drwa_ocr_widget.build:widget.strokeWidth:${widget.strokeWidth}");

    if (widget.points.isEmpty) {
      predictLabel = "";
    }

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    RenderBox renderBox =
                        context.findRenderObject() as RenderBox;
                    widget.points
                        .add(renderBox.globalToLocal(details.globalPosition));
                  });
                },
                onPanStart: (details) {
                  setState(() {
                    RenderBox renderBox =
                        context.findRenderObject() as RenderBox;
                    widget.points
                        .add(renderBox.globalToLocal(details.globalPosition));
                  });
                },
                onPanEnd: (details) async {
                  widget.points.add(null);
                  _digitPredictions();
                },
                child: ClipRect(
                  child: CustomPaint(
                    size: Size(widget.width, widget.height),
                    painter: DrawingPainter(
                      offsetPoints: widget.points,
                      drawingPaint: drawingPaint,
                    ),
                  ),
                ),
              );
            },
          ),
          _buildClearIcon(),
          Positioned(
            left: drawingPaint!.strokeWidth == 5.0 ? 0 : 10,
            top: drawingPaint!.strokeWidth == 5.0 ? -2 : 5,
            child: Text(
              predictLabel,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: drawingPaint!.strokeWidth == 5.0 ? 20 : 30,
                  color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClearIcon() {
    return drawingPaint!.strokeWidth == 5.0
        ? Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              onTap: cleanDrawing,
              child: const Icon(
                FontAwesomeIcons.eraser,
                color: AppColors.mainColor,
              ),
            ),
          )
        :
        //IconButton 으로 하면 click 영역이 많아져서 draw 하기 불편하다.
        Positioned(
            right: -5,
            top: -10,
            child: IconButton(
              onPressed: cleanDrawing,
              icon: const Icon(
                FontAwesomeIcons.eraser,
                color: AppColors.mainColor,
              ),
            ),
          );
  }
}
