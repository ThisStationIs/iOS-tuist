import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

let project = Project.makeApp(
    name: "ThisStationIsTuist",
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.ipad]),
    infoPlist: .default
)
