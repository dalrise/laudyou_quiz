import 'package:flutter/cupertino.dart';

class Dimensions {
  // static Dimensions? _instance;
  //
  // factory Dimensions.newInstance(BuildContext context) {
  //   _instance ??= Dimensions._internal(context);
  //
  //   return _instance!;
  // }
  // Dimensions._internal(this._context);

  final BuildContext _context;

  late double screenWidth;

  late double font14;
  late double font16;
  late double font18;
  late double font20;
  late double font24;
  late double font27;
  late double font30;
  late double font45;
  late double font50;
  late double font90;

  Dimensions(this._context) {
    screenWidth = MediaQuery.of(_context).size.width;

    font14 = screenWidth / 28.57;
    font16 = screenWidth / 25.0;
    font18 = screenWidth / 22.22;
    font20 = screenWidth / 20.0;
    font24 = screenWidth / 16.66;
    font27 = screenWidth / 14.81;
    font30 = screenWidth / 13.33;
    font45 = screenWidth / 8.88;
    font50 = screenWidth / 8.0;
    font90 = screenWidth / 4.44;
  }

  // get screenWidth {
  //   return _screenWidth;
  // }

}
