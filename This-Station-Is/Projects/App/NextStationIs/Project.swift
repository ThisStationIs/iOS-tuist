import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.makeApp(
    name: "NextStationIs",
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
    dependencies: [
        .Module.CommonProtocol,
        .Module.ThirdPartyManager,
        .Module.LoginFeature,
        .Module.BoardFeature,
        .Module.MyPageFeature,
        .Module.HistoryFeature,
        .Module.HomeFeature
    ],
    infoPlist: .file(path: "Supports/Info.plist")
)
