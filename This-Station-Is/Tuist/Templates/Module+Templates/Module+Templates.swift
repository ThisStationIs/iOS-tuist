//
//  Module+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Muzlive_Player on 2023/12/15.
//

import ProjectDescription

let nameAttribute = Template.Attribute.required("name")
let authorAttribute = Template.Attribute.optional("author", default: "unknown")

let template = Template(
    description: "This is \(nameAttribute) module. Author is \(authorAttribute)",
    attributes: [
        nameAttribute,
        authorAttribute
    ],
    items: [
        [
            .file(path: "Projects/Modules/\(nameAttribute)/Samples/Sources/AppDelegate.swift", templatePath: "appdelegate.stencil"),
            .file(path: "Projects/Modules/\(nameAttribute)/Samples/Resources/Assets.xcassets/contents.json", templatePath: "xcassets.stencil")
            .file(path: "Projects/Modules/\(nameAttribute)/Samples/Resources/Assets.xcassets/AppIcon.appiconset/contents.json", templatePath: "appIcon.stencil")
        ],
        [
            .file(path: "Projects/Modules/\(nameAttribute)/Sources/\(nameAttribute).swift", templatePath: "sources.stencil"),
            .string(path: "Projects/Modules/\(nameAttribute)/Tests/dummy.txt", contents: "_"),
            .string(path: "Projects/Modules/\(nameAttribute)/Resources/dummy.txt", contents: "_")
        ],
        [
            .file(path: "Projects/Modules/\(nameAttribute)/Project.swift", templatePath: "project.stencil")
        ]
    ].flatMap { $0 }
)


