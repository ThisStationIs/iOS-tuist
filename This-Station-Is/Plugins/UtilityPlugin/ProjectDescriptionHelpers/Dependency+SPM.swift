//
//  Dependency+SPM.swift
//  MyPlugin
//
//  Created by Muzlive_Player on 2023/12/19.
//

import ProjectDescription

extension TargetDependency {
    public enum SPM {}
}

//public extension Package {
//}

public extension TargetDependency.SPM {
    static let Then = TargetDependency.external(name: "Then")
    static let SnapKit = TargetDependency.external(name: "SnapKit")
    static let SwiftyJSON = TargetDependency.external(name: "SwiftyJSON")
    static let IQKeyboardManager = TargetDependency.external(name: "IQKeyboardManagerSwift")
}

