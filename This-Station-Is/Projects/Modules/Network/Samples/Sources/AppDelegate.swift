import Foundation
import UIKit
import Network

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = UIViewController()
        vc.title = "Network"
        vc.view.backgroundColor = .systemYellow
        
        APIServiceManager().request(with: getTerms()) { result in
            switch result {
            case .success(let success):
                print("### success is \(success)")
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: vc)
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate {
    func getTerms() -> Endpoint<TempResponse> {
        return Endpoint(
            baseURL: "http://ec2-3-37-127-228.ap-northeast-2.compute.amazonaws.com",
            path: "api/v1/terms/TERMS01"
        )
    }
}

struct TempResponse: Decodable {
    let terms: String
    let isRequired: Bool
    let downloadableUrl: String

    private enum CodingKeys: String, CodingKey {
        case terms
        case isRequired
        case downloadableUrl
    }
}
