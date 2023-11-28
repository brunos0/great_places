import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    struct Environment {
        static let infoDictionary: [String: Any] = {
            guard let dict = Bundle.main.infoDictionary else {
                fatalError("Arquivo Info.plist não encontrado")
            }
            return dict
        }()
    }
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        guard let apiKey = Environment.infoDictionary["API_KEY_MAPS_IOS"] as? String else {
            fatalError("API_KEY_MAPS_IOS não definida no plist")
        }
        GMSServices.provideAPIKey(apiKey)
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
