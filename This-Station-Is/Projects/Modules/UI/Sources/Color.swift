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

extension UIColor {
    public class var componentButton: UIColor {
        return UIColor(named: "componentButton")!
    }
    
    public class var componentDisable: UIColor {
        return UIColor(named: "componentDisable")!
    }
    
    public class var componentDivider: UIColor {
        return UIColor(named: "componentDivider")!
    }
    
    public class var componentIcon: UIColor {
        return UIColor(named: "componentIcon")!
    }
    
    public class var componentTextbox: UIColor {
        return UIColor(named: "componentTextbox")!
    }
    
    public class var primaryNormal: UIColor {
        return UIColor(named: "primaryNormal")!
    }
    
    public class var statusNegative: UIColor {
        return UIColor(named: "statusNegative")!
    }
    
    public class var statusPositive: UIColor {
        return UIColor(named: "statusPositive")!
    }
    
    public class var textMain: UIColor {
        return UIColor(named: "textMain")!
    }
    
    public class var textSub: UIColor {
        return UIColor(named: "textSub")!
    }
    
    public class var textTeritory: UIColor {
        return UIColor(named: "textTeritory")!
    }
}
