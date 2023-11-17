import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let envChannel = FlutterMethodChannel(name: "com.example.great_places/iosbridge",
                                          binaryMessenger: controller.binaryMessenger)
    envChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      guard call.method == "getApiKey" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self.receiveApiKey(call: call, result: result)
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func receiveApiKey(call: FlutterMethodCall, result: FlutterResult) {
    guard let args = call.arguments else {
      result("iOS could not recognize flutter arguments in method: (getApiKey)")
      return
    }
    if let apiKey = args as? String {
      GMSServices.provideAPIKey(apiKey)
      result("API Key received")
    } else {
      result(FlutterError(code: "-1", message: "ERROR", details: nil))
    }
  }
}
