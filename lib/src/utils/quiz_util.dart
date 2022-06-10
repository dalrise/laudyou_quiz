class QuizUtil {
  /// 표현에서 square 로 표현되는 개수의 알파벳을 리턴 - "3,square{1},*,4,=,square{b},=,frac{[c]}{[d]}"
  ///
  static List<String> getSquareBoxSize(String expression) {
    List<String> list = [];

    RegExp regexp = RegExp('square{(\\w){1}}');
    Iterable<Match> matches = regexp.allMatches(expression);
    list = matches.map((e) => e.group(1)!).toList();

    final list2 = expression
        .split(",")
        .where((element) => element.startsWith("frac{["))
        .map((text) {
          RegExp regexp = RegExp('\\[(\\w){1}\\]');
          Iterable<Match> matches = regexp.allMatches(text);
          return matches.map((e) => e.group(1)!);
        })
        .toList()
        .expand((element) => element)
        .toList();

    list.addAll(list2);
    //print(list);
    return list;
  }
}
