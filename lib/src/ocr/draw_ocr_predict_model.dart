class DrawOcrPredictModel {
  final String value;
  final int ocrIndex;

  DrawOcrPredictModel({required this.value, required this.ocrIndex});

  dynamic toJson() => {'value': value, 'ocrIndex': ocrIndex};

  @override
  String toString() {
    return toJson().toString();
  }
}
