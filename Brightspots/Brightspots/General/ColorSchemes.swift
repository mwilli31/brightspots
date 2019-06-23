//
//  ColorScheme.swift
//  Brightspots
//
//  Created by Michael Williams on 3/7/19.
//  Copyright © 2019 Michael Williams. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialColorScheme

struct Colors {
    static let NIGHT_BLUE = "#000031"
    static let LIGHT_BLUE = "#09F5ED"
    static let LIGHT_GREEN = "#06F6A8"
    static let BRIGHT_ORANGE = "#FF8126"
    static let BRIGHT_PINK = "#FF117E"
    static let WHITE = "#FFFFFF"
    static let SKY_BLUE = "#F3FFFC"
}

public class MainColorScheme: MDCSemanticColorScheme {
    
    override public init() {
        super.init()
        self.primaryColor = UIColor.init(hex: Colors.LIGHT_BLUE)
        self.primaryColorVariant = UIColor.init(hex: Colors.LIGHT_GREEN)
        self.secondaryColor = UIColor.init(hex: Colors.BRIGHT_PINK)
        self.backgroundColor = UIColor.init(hex: Colors.WHITE)
        self.surfaceColor = UIColor.init(hex: Colors.NIGHT_BLUE)
        self.errorColor = UIColor.init(hex: Colors.BRIGHT_ORANGE)
        //        self.primaryColor = UIColor.init(hex:"#00A0E1")
        //        self.primaryColorVariant = UIColor.init(hex: "#55CCFF")
        //        self.secondaryColor = UIColor.init(hex: "#BD10E0")
        //        self.backgroundColor = UIColor.init(hex: "#FFFFFF")
        //        self.surfaceColor = UIColor.init(hex: "#FFFFFF")
        //        self.errorColor = UIColor.init(hex: "#F42B3C")
        
    }
    
    override public init(defaults: MDCColorSchemeDefaults) {
        super.init(defaults: defaults)
    }
    
}

public class SignUpColorScheme: MDCSemanticColorScheme {
    
    let fourthButtonColor = UIColor.init(hex:"#2BB8FF")
    let fifthButtonColor = UIColor.init(hex:"#79D6FF")
    
    override public init() {
        super.init()
        self.primaryColor = UIColor.init(hex:"#09F5ED")
        self.primaryColorVariant = UIColor.init(hex: "#06F6A8")
        self.secondaryColor = UIColor.init(hex: "#0396DA")
        self.backgroundColor = UIColor.init(hex: "#FFFFFF")
        self.surfaceColor = UIColor.init(hex: "#FFFFFF")
        self.errorColor = UIColor.init(hex: "#F42B3C")
    }
    
    override public init(defaults: MDCColorSchemeDefaults) {
        super.init(defaults: defaults)
    }
    
}

public class ChartColorScheme: MDCSemanticColorScheme {
    
    let referenceLineColor = UIColor.init(hex: Colors.SKY_BLUE)
    var rangeLineColor = UIColor.init(hex: Colors.SKY_BLUE).withAlphaComponent(0.5)
    let bigRangeLineColor = UIColor.init(hex: Colors.LIGHT_GREEN).withAlphaComponent(0.35)
    
    override public init() {
        super.init()
        self.primaryColor = UIColor.init(hex: Colors.LIGHT_BLUE)
        self.primaryColorVariant = UIColor.init(hex: Colors.LIGHT_GREEN)
        self.secondaryColor = UIColor.init(hex: Colors.BRIGHT_PINK)
        self.backgroundColor = UIColor.init(hex: Colors.WHITE)
        self.surfaceColor = UIColor.init(hex: Colors.NIGHT_BLUE)
        self.errorColor = UIColor.init(hex: Colors.BRIGHT_ORANGE)
    }
    
    override public init(defaults: MDCColorSchemeDefaults) {
        super.init(defaults: defaults)
    }
    
}

public class BloodGlucoseColorScheme: MDCSemanticColorScheme {
    
    override public init() {
        super.init()
        self.primaryColor = UIColor.init(hex: Colors.LIGHT_BLUE)
        self.secondaryColor = UIColor.init(hex: Colors.BRIGHT_ORANGE)
        self.backgroundColor = UIColor.init(hex: Colors.WHITE)
        self.surfaceColor = UIColor.init(hex: Colors.WHITE)
        self.errorColor = UIColor.init(hex: Colors.BRIGHT_PINK)
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
