import Foundation
import UIKit
import BoardFeature

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let naviagationController = UINavigationController(rootViewController: BoardViewController())
        naviagationController.view.backgroundColor = .white
        
        self.window = UIWindow(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.window?.rootViewController = naviagationController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
