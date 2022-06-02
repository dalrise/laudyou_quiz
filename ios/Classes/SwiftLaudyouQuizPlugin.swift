import Flutter
import UIKit

public class SwiftLaudyouQuizPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "laudyou_quiz", binaryMessenger: registrar.messenger())
    let instance = SwiftLaudyouQuizPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
