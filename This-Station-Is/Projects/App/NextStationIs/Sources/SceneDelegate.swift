import UIKit
import LoginFeature
import Network
import CommonProtocol
import IQKeyboardManagerSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        
//        IQKeyboardManager.shared.enable = true
//        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        // 다크모드 해제
        window?.overrideUserInterfaceStyle = .light
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let isLogin = UserDefaults.standard.bool(forKey: "isLogin")
        NotificationCenter.default.addObserver(self, selector: #selector(updateRootViewController), name: NSNotification.Name(rawValue: "MoveToMain"), object: nil)
        print("### isLogin: \(isLogin)")
        DataManager.shared.getSubwayLine {
            DispatchQueue.main.async {
                self.window?.rootViewController = isLogin ? MainTabBarController() : UINavigationController(rootViewController: LoginViewController()
                )
                self.window?.makeKeyAndVisible()
            }
        }
    }
    
    @objc func updateRootViewController(notification: NSNotification) {
        DispatchQueue.main.async {
            self.window?.rootViewController = MainTabBarController()
            self.window?.makeKeyAndVisible()
        }
    }


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

extension SceneDelegate {
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
              let path = components.path,
              let params = components.queryItems else {
            print("Invalid URL or path missing")
            return
        }

        if path == "new-password" {
            DispatchQueue.main.async {
                let resetPasswordViewController = InputNewPasswordViewController()
                self.window?.rootViewController = resetPasswordViewController
                self.window?.makeKeyAndVisible()
            }
        }
    }
}
