import 'package:flutter_test/flutter_test.dart';
import 'package:laudyou_quiz/src/utils/quiz_util.dart';

void main() {
  test("express 에서 box 의 개수를 3개 리턴", () {
    List<String> list =
        QuizUtil.getSquareBoxSize("4,*,4,=,square{a},=,frac{[b]}{[c]}");

    expect(list.length, 3);
  });

  test("express 에서 box 의 개수를 6개 리턴", () {
    List<String> list = QuizUtil.getSquareBoxSize(
        "3,square{1},4,*,4,=,square{a},=,frac{[b]}{[c]},frac{[b]}{[c]}");

    expect(list.length, 6);
  });
}
