import 'package:flutter_test/flutter_test.dart';
import 'package:laudyou_quiz/laudyou_quiz.dart';
import 'package:laudyou_quiz/laudyou_quiz_platform_interface.dart';
import 'package:laudyou_quiz/laudyou_quiz_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLaudyouQuizPlatform
    with MockPlatformInterfaceMixin
    implements LaudyouQuizPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LaudyouQuizPlatform initialPlatform = LaudyouQuizPlatform.instance;

  test('$MethodChannelLaudyouQuiz is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLaudyouQuiz>());
  });

  test('getPlatformVersion', () async {
    // LaudyouQuiz laudyouQuizPlugin = LaudyouQuiz();
    // MockLaudyouQuizPlatform fakePlatform = MockLaudyouQuizPlatform();
    // LaudyouQuizPlatform.instance = fakePlatform;
    //
    // expect(await laudyouQuizPlugin.getPlatformVersion(), '42');
  });
}
