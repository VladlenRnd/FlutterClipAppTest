import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    override func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        respondTo(userActivity)

    return true
    }
    
    

    
    func respondTo(_ activity: NSUserActivity?) {
        // Guard against faulty data.
        guard activity != nil else { return }
        guard activity!.activityType == NSUserActivityTypeBrowsingWeb else { return }
        guard let incomingURL = activity?.webpageURL else { return }
        guard let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true) else { return }

        print(components)
        
        let channelName = "wingquest.stablekernel.io/speech"
        let rootViewController : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: rootViewController as! FlutterBinaryMessenger)

        methodChannel.setMethodCallHandler {(call: FlutterMethodCall, result: FlutterResult) -> Void in
            if (call.method == "start") {
               print(incomingURL)
                result(incomingURL.absoluteString);
                
            }
            result("test")
        }
        
        
        
        // Update the user interface based on URL components passed to the App Clip or full app.
    }

       

}
