//
//  Dependencies.swift
//  Config
//
//  Created by min on 2023/12/19.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let dependencis = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/devxoul/Then", requirement: .upToNextMajor(from: "2")),
        .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.0.1")),
        .remote(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", requirement: .upToNextMajor(from: "4.0.0"))
    ],
    platforms: [.iOS]
)
