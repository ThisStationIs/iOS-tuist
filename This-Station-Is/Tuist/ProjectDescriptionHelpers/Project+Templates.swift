import ProjectDescription

extension Project {
    /// Helper function to create the Project for this ExampleApp
    public static func makeApp(
        name: String,
        platform: Platform = .iOS,
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget,
        dependencies: [TargetDependency] = [],
        infoPlist: InfoPlist
    ) -> Project {
        return Project(
            name: name
        )
    }
}
