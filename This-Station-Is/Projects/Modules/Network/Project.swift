import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Network",
    product: .staticLibrary,
    deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone]),
    dependencies: [],
    infoPlist: configureInfoPlist()
)

private func configureInfoPlist(merging other: [String: InfoPlist.Value] = [:]) -> InfoPlist {
    var extendedPlist: [String: InfoPlist.Value] = [
        "NSAppTransportSecurity": "NSAllowsArbitraryLoads"
    ]
    return InfoPlist.extendingDefault(with: extendedPlist)
}
