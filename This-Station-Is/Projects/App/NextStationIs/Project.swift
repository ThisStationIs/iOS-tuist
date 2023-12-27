import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.makeApp(
    name: "NextStationIs",
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
    dependencies: [
    ],
    infoPlist: .file(path: "Supports/Info.plist")
)
