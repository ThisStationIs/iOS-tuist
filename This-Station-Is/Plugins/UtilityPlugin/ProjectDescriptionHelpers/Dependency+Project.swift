//
//  TargetDependency+Project.swift
//  MyPlugin
//
//  Created by Muzlive_Player on 2023/12/19.
//

import ProjectDescription

extension TargetDependency {
    public enum App {}
    public enum Module {}
}

public extension TargetDependency.App {
    static func project(name: String) -> TargetDependency {
        .project(target: name, path: .relativeToRoot("Projects/App/\(name)"))
    }
}

public extension TargetDependency.Module {
    static func project(name: String) -> TargetDependency {
        .project(target: name, path: .relativeToRoot("Projects/Modules/\(name)"))
    }
    
    static let ThirdPartyManager = project(name: "ThirdPartyManager")
    static let CommonProtocol = project(name: "CommonProtocol")
    
    static let Network = project(name: "Network")
    static let UI = project(name: "UI")
    
    // MARK: - Features
    static let LoginFeature = project(name: "LoginFeature")
    static let BoardFeature = project(name: "BoardFeature")
    static let HistoryFeature = project(name: "HistoryFeature")
    static let MyPageFeature = project(name: "MyPageFeature")
}
