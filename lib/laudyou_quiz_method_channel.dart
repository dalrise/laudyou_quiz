import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'laudyou_quiz_platform_interface.dart';

/// An implementation of [LaudyouQuizPlatform] that uses method channels.
class MethodChannelLaudyouQuiz extends LaudyouQuizPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('laudyou_quiz');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
