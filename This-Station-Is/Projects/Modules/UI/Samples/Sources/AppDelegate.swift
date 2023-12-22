import Foundation
import UIKit
import UI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let toast = Toast(type: .error)
  
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = UIViewController()
        vc.title = "UI"
        vc.view.backgroundColor = .systemYellow
        
        let button = Button()
        button.title = "aaa"
        vc.view.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        button.addTarget(self, action: #selector(selectButton), for: .touchUpInside)
        
        let inputBox = InputBox(title: "타이틀", error: "에러")
        vc.view.addSubview(inputBox)
        inputBox.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        let badge = CategoryBadge()
        badge.title = "1호선"
        badge.setType(.background)
        vc.view.addSubview(badge)
        badge.snp.makeConstraints {
            $0.top.equalTo(inputBox.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        let radioButton = RadioButton()
        radioButton.isOn = true
        vc.view.addSubview(radioButton)
        radioButton.snp.makeConstraints {
            $0.top.equalTo(badge.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        let checkbox = CheckBox()
        checkbox.isCheck = true
        vc.view.addSubview(checkbox)
        checkbox.snp.makeConstraints {
            $0.top.equalTo(badge.snp.bottom).offset(10)
            $0.leading.equalTo(radioButton.snp.trailing).offset(10)
        }
        
        let toggle = Toggle()
        vc.view.addSubview(toggle)
        toggle.snp.makeConstraints {
            $0.top.equalTo(badge.snp.bottom).offset(10)
            $0.leading.equalTo(checkbox.snp.trailing).offset(10)
        }
        
        //        toast.snp.makeConstraints {
        //            $0.top.equalTo(badge.snp.bottom).offset(10)
        //            $0.leading.trailing.equalToSuperview()
        //        }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: vc)
        self.window?.makeKeyAndVisible()
        
        
        return true
    }
    
    @objc func selectButton() {
//        toast.show()
        let alertView = AlertView(title: "aaa", message: "212sdasdsadsdsdasdsadsdsdsdasdldkfaskdhaskfhklsadfhlskdfhdsjkfhsdkjfhksdfhs;lkjsASld;sjl;kdjasldkjasl;fhdkafjsdaklfjsdl;fkjkdlsfjdsklfjldskfjdslkjkl")
        alertView.addAction(title: "닫기", style: .cancel)
        alertView.addAction(title: "완료", style: .destructive)
        alertView.present()
    }
}
