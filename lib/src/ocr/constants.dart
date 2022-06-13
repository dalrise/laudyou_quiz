// TODO Implement this library.import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:flutter/material.dart';

const int kModelInputSize = 300; //300; //28;
const double kCanvasInnerOffset = 40.0;
//const double kCanvasSize = 200;//300; //200.0;
const double kStrokeWidth = 5.0; // 두께
const Color kBlackBrushColor = Colors.black;
const bool kIsAntiAlias = true;
const Color kBrushBlack = Colors.black;
const Color kBrushWhite = Colors.white;

final Paint kDrawingPaint = Paint()
  ..strokeCap = StrokeCap.square
  ..isAntiAlias = kIsAntiAlias
  ..color = kBrushBlack
  ..strokeWidth = kStrokeWidth;

final Paint kWhitePaint = Paint()
  ..strokeCap = StrokeCap.square
  ..isAntiAlias = kIsAntiAlias
  ..color = kBrushWhite
  ..strokeWidth = kStrokeWidth;

final kBackgroundPaint = Paint()..color = kBrushBlack;
