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
    ],
    infoPlist: configureInfoPlist()
)

private func configureInfoPlist(merging other: [String: InfoPlist.Value] = [:]) -> InfoPlist {
    var extendedPlist: [String: InfoPlist.Value] = [:]
    return InfoPlist.extendingDefault(with: extendedPlist)
}
