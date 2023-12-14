//
//  Scheme+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Muzlive_Player on 2023/12/14.
//

import ProjectDescription

extension Scheme {
    static func makeScheme(
        name: String,
        _ configurationName: ConfigurationName
    ) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: configurationName,
                options: .options(
                    coverage: true,
                    codeCoverageTargets: ["\(name)"]
                )
            ),
            runAction: .runAction(configuration: configurationName),
            archiveAction: .archiveAction(configuration: configurationName),
            profileAction: .profileAction(configuration: configurationName),
            analyzeAction: .analyzeAction(configuration: configurationName)
        )
    }
}
