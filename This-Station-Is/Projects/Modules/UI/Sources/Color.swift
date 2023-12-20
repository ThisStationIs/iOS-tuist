//
//  Color.swift
//  UI
//
//  Created by min on 2023/12/20.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import UIKit

enum ColorSet {
    case componentButton
    case componentDisable
    case componentDivider
    case componentIcon
    case componentTextbox
    
    case primaryNormal
    
    case statusNegative
    case statusPositive
    
    case textMain
    case textSub
    case textTeritory
}


struct AppColor {
    static func setupColor(_ name: ColorSet) -> UIColor {
        switch name {
        case .componentButton:
            return UIColor(named: "componentButton")!
        case .componentDisable:
            return UIColor(named: "componentDisable")!
        case .componentDivider:
            return UIColor(named: "componentDivider")!
        case .componentIcon:
            return UIColor(named: "componentIcon")!
        case .componentTextbox:
            return UIColor(named: "componentTextbox")!
        case .primaryNormal:
            return UIColor(named: "primaryNormal")!
        case .statusNegative:
            return UIColor(named: "statusNegative")!
        case .statusPositive:
            return UIColor(named: "statusPositive")!
        case .textMain:
            return UIColor(named: "textMain")!
        case .textSub:
            return UIColor(named: "textSub")!
        case .textTeritory:
            return UIColor(named: "textTeritory")!
        }
    }
}
