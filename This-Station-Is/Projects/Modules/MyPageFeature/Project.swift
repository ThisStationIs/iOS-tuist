import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.makeModule(
    name: "MyPageFeature",
    product: .staticLibrary,
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
    dependencies: [
        .Module.ThirdPartyManager,
        .Module.UI,
        .Module.Network,
        .Module.CommonProtocol
    ],
    infoPlist: configureInfoPlist()
)

private func configureInfoPlist(merging other: [String: InfoPlist.Value] = [:]) -> InfoPlist {
    var extendedPlist: [String: InfoPlist.Value] = [:]
    return InfoPlist.extendingDefault(with: extendedPlist)
}
