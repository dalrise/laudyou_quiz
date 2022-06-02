#import "LaudyouQuizPlugin.h"
#if __has_include(<laudyou_quiz/laudyou_quiz-Swift.h>)
#import <laudyou_quiz/laudyou_quiz-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "laudyou_quiz-Swift.h"
#endif

@implementation LaudyouQuizPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLaudyouQuizPlugin registerWithRegistrar:registrar];
}
@end
