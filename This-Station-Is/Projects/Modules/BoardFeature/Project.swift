import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin
// BoardFeature
let project = Project.makeModule(
    name: "BoardFeature",
    product: .staticFramework,
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
    dependencies: [
        .Module.ThirdPartyManager,
        .Module.UI,
        .Module.Network
    ],
    infoPlist: configureInfoPlist()
)

private func configureInfoPlist(merging other: [String: InfoPlist.Value] = [:]) -> InfoPlist {
    var extendedPlist: [String: InfoPlist.Value] = [:]
    
    let infoPlist: [String: InfoPlist.Value] = [
        "CFBundleVersion": "1",
        "UILaunchStoryboardName": "LaunchScreen",
        "NSAppTransportSecurity": [
            "NSAllowsArbitraryLoads": true
        ],
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ],
                ]
            ]
        ],
    ]
    
    return InfoPlist.extendingDefault(with: infoPlist)
}
