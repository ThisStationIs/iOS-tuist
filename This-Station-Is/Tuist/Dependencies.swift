//
//  Dependencies.swift
//  Config
//
//  Created by min on 2023/12/19.
//

import ProjectDescription

public extension Package {
    static let snapKit: Package = .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.0.1"))
}

//let dependencies = Dependencies(
//    carthage: [],
//    swiftPackageManager: [
//        .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.0.1")),
//    ],
//    platforms: [.iOS]
//)


let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .snapKit
        ]
    ),
    platforms: [.iOS]
)
