import ProjectDescription
import ProjectDescriptionHelpers

private let projectName = "UI"
private let iOSTargetVersion = "15.0"


let project = Project.makeModule(
    name: "UI",
    product: .staticLibrary,
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
    dependencies: [],
    infoPlist: configureInfoPlist()
)

private func configureInfoPlist(merging other: [String: InfoPlist.Value] = [:]) -> InfoPlist {
    var extendedPlist: [String: InfoPlist.Value] = [:]
    return InfoPlist.extendingDefault(with: extendedPlist)
}
