import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.makeApp(
    name: "MetroStory",
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
    dependencies: [
        .Module.CommonProtocol,
        .Module.ThirdPartyManager,
        .Module.LoginFeature,
        .Module.BoardFeature,
    ],
    infoPlist: .file(path: "Supports/Info.plist")
)
