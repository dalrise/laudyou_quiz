import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laudyou_quiz/laudyou_quiz_method_channel.dart';

void main() {
  MethodChannelLaudyouQuiz platform = MethodChannelLaudyouQuiz();
  const MethodChannel channel = MethodChannel('laudyou_quiz');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
