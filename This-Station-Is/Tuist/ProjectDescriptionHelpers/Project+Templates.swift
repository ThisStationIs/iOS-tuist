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
        
        let options: Options = .options()
        
        let settings: Settings = .settings(
            base: [:],
            configurations: [
                .debug(name: .debug, settings: [
                    "CODE_SIGN_STYLE": "Automatic",
                    "DEVELOPMENT_TEAM": "L8WBW3DU2X" // TODO: 수정
                ]),
                .release(name: .release, settings: [
                    "CODE_SIGN_STYLE": "Automatic",
                    "DEVELOPMENT_TEAM": "L8WBW3DU2X" // TODO: 수정
                ])
            ],
            defaultSettings: .recommended
        )
        
        let targets = makeTargets(
            name: name,
            platform: platform,
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            dependencies: dependencies
        )
        
        let schemes: [Scheme] = [
            .makeScheme(name: name, .debug)
        ]
        
        return Project(
            name: name,
            organizationName: "This-Station-Is", // TODO: 수정
            options: options,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }
}


extension Project {
    public static func makeTargets(
        name: String,
        platform: Platform,
        deploymentTarget: DeploymentTarget,
        infoPlist: InfoPlist,
        dependencies: [TargetDependency]
    ) -> [Target] {
        return []
    }
}
