//
//  ColorScheme.swift
//  Brightspots
//
//  Created by Michael Williams on 3/7/19.
//  Copyright © 2019 Michael Williams. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialColorScheme

public class MainColorScheme: MDCSemanticColorScheme {

    override public init() {
        super.init()
        self.primaryColor = UIColor.init(hex:"#00A0E1")
        self.primaryColorVariant = UIColor.init(hex: "#55CCFF")
        self.secondaryColor = UIColor.init(hex: "#BD10E0")
        self.backgroundColor = UIColor.init(hex: "#FFFFFF")
        self.surfaceColor = UIColor.init(hex: "#FFFFFF")
        self.errorColor = UIColor.init(hex: "#F42B3C")
    }
    
    override public init(defaults: MDCColorSchemeDefaults) {
        super.init(defaults: defaults)
    }

}

public class ChartColorScheme: MDCSemanticColorScheme {
    
    let referenceLineColor = UIColor.init(hex:"#0F93E3")
    var rangeLineColor = UIColor.init()
    let bigRangeLineColor = UIColor.init(hex: "#FF7B00").withAlphaComponent(0.2)

    override public init() {
        super.init()
        self.primaryColor = UIColor.init(hex:"#00A0E1")
        self.primaryColorVariant = UIColor.init(hex: "#55CCFF")
        self.secondaryColor = UIColor.init(hex: "#BD10E0")
        self.backgroundColor = UIColor.init(hex: "#FFFFFF")
        self.surfaceColor = UIColor.init(hex: "#FFFFFF")
        self.errorColor = UIColor.init(hex: "#F42B3C")
        self.rangeLineColor = self.primaryColorVariant.withAlphaComponent(0.5)
    }
    
    override public init(defaults: MDCColorSchemeDefaults) {
        super.init(defaults: defaults)
    }
    
}

public class BloodGlucoseColorScheme: MDCSemanticColorScheme {
    
    override public init() {
        super.init()
        self.primaryColor = UIColor.init(hex:"#00A0E1")
        self.secondaryColor = UIColor.init(hex: "#FFE200")
        self.backgroundColor = UIColor.init(hex: "#FFFFFF")
        self.surfaceColor = UIColor.init(hex: "#FFFFFF")
        self.errorColor = UIColor.init(hex: "#F42B3C")
    }
    
    override public init(defaults: MDCColorSchemeDefaults) {
        super.init(defaults: defaults)
    }
    
    // Changes the color to red if blood glucose is bad :-/
    func getBgColor(_ bg : String) -> UIColor {
        
        guard let bgNumber : Int = Int(bg) else {
            return UIColor.white
        }
        if bgNumber > 200 {
            return self.errorColor
        } else if bgNumber > 180 {
            return self.secondaryColor
        } else {
            return self.primaryColor
        }
    }
    
    func getDeltaLabelColor(_ bgdelta : NSNumber) -> UIColor {
        
        let absoluteDelta = abs(bgdelta.int32Value)
        if (absoluteDelta >= 10) {
            return self.errorColor
        } else if (absoluteDelta >= 5) {
            return self.secondaryColor
        } else {
            return self.primaryColor
        }
    }
    
//    func getTimeLabelColor(_ lastUpdate : NSNumber) -> UIColor {
//        
//        let lastUpdateAsNSDate : Date = Date(timeIntervalSince1970: lastUpdate.doubleValue / 1000)
//        let timeInterval : Int = Int(Date().timeIntervalSince(lastUpdateAsNSDate))
//        if (timeInterval > 15*60) {
//            return RED
//        } else if (timeInterval > 7*60) {
//            return YELLOW
//        } else {
//            return UIColor.white
//        }
//    }
    
}

extension UIColor {
    convenience init(r: Int, g: Int, b: Int) {
        let cR : CGFloat = pow(pow((CGFloat(r)/255.0),2.2), 0.4545)
        let cG : CGFloat = pow(pow((CGFloat(g)/255.0),2.2), 0.4545)
        let cB : CGFloat = pow(pow((CGFloat(b)/255.0),2.2), 0.4545)
        self.init(red: CGFloat(cR), green: CGFloat(cG), blue: CGFloat(cB), alpha: 1.0)
    }
    
    convenience init(hex:String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
