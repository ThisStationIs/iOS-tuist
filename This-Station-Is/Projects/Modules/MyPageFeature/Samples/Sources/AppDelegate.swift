import Foundation
import UIKit
import MyPageFeature

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let naviagationController = UINavigationController(rootViewController: MyPageViewController())
        naviagationController.view.backgroundColor = .white
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = naviagationController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
