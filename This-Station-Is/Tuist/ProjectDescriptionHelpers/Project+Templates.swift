import ProjectDescription

extension Project {
    static let baseBundleId: String = "com.kkonmo"
    
    public static func makeApp(
        name: String,
        platform: Platform = .iOS,
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget,
        dependencies: [TargetDependency] = [],
        infoPlist: InfoPlist
    ) -> Project {
        
        let options: Options = .options()
        
        let settings: Settings = getSettings()
        
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
            organizationName: "Kkonmo", // TODO: 수정
            options: options,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }
    
    private static func makeTargets(
        name: String,
        platform: Platform,
        deploymentTarget: DeploymentTarget,
        infoPlist: InfoPlist,
        dependencies: [TargetDependency]
    ) -> [Target] {
        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: baseBundleId + ".\(name)",
            deploymentTarget: deploymentTarget,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: dependencies
        )
        
        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: baseBundleId + ".\(name)Tests",
            deploymentTarget: deploymentTarget,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: name),
                .xctest
            ]
        )
        
        return [mainTarget, testTarget]
    }
}

extension Project {
    public static func makeModule(
        name: String,
        platform: Platform = .iOS,
        product: Product,
        organizationName: String = "Kkonmo",
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget,
        dependencies: [TargetDependency] = [],
        resources: ResourceFileElements? = nil,
        baseSetting: [String: SettingValue] = [:],
        infoPlist: InfoPlist = .default
    ) -> Project {
        let settings: Settings = getSettings()
        
        let schemes: [Scheme] = [
            .makeScheme(name: name, .debug)
        ]
        
        let targets: [Target] = makeModuleTargets(
            name: name,
            platform: platform,
            product: product,
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            dependencies: dependencies,
            resources: resources
        )
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }
    
    private static func makeModuleTargets(
        name: String,
        platform: Platform,
        product: Product,
        deploymentTarget: DeploymentTarget,
        infoPlist: InfoPlist,
        dependencies: [TargetDependency],
        resources: ResourceFileElements? = nil
    ) -> [Target] {
        let mainTarget = Target(
            name: "\(name)",
            platform: platform,
            product: product,
            bundleId: baseBundleId + ".\(name)",
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: ["Sources/**"],
            resources: resources,
            dependencies: dependencies
        )
        
        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: product,
            bundleId: baseBundleId + ".\(name)Tests",
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: name),
                .xctest
            ]
        )
        
        let sampleTarget = Target(
            name: "\(name)Sample",
            platform: platform,
            product: product,
            bundleId: baseBundleId + ".\(name)Sample",
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: ["Samples/**"],
            resources: ["Samples/Resources/**"],
            dependencies: [
                .target(name: name)
            ]
        )
        
        return [mainTarget, testTarget, sampleTarget]
    }
}


extension Project {
    private static func getSettings(
        codeSignStyle: SettingValue = "Automatic",
        developmentTeam: SettingValue = ""
    ) -> Settings {
        return .settings(
            base: [:],
            configurations: [
                .debug(
                    name: .debug,
                    settings: [
                        "CODE_SIGN_STYLE": codeSignStyle,
                        "DEVELOPMENT_TEAM": developmentTeam // TODO: 수정
                    ]
                )
            ],
            defaultSettings: .recommended
        )
    }
}
