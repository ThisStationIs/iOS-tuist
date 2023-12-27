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
    
    public convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

