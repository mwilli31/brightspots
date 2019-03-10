//
//  Constants.swift
//  Brightspots
//
//  Created by Michael Williams on 3/7/19.
//  Copyright © 2019 Michael Williams. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialColorScheme

//main color scheme
let mainColorScheme = MainColorScheme()
let chartColorScheme = ChartColorScheme()
let bloodGlucoseColorScheme = BloodGlucoseColorScheme()

//glucose settings
var LINE_CHART_GLUCOSE_RANGE = CGFloat(40)
var LINE_CHART_GLUCOSE_MID = CGFloat(100)
var LINE_CHART_BIG_GLUCOSE_RANGE = CGFloat(135)
var LINE_CHART_BIG_GLUCOSE_MID = CGFloat(135)

struct Constants {
    
    struct Font {
        static let INTRO_TITLE = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.thin)
        static let INTRO_DESCRIPTION = UIFont.systemFont(ofSize: 18)

        static let LINE_CHART_LABEL_FONT = UIFont.systemFont(ofSize: 14)
        static let CURRENT_BG_LABEL_FONT = UIFont.systemFont(ofSize: 48, weight: UIFont.Weight.thin)
        static let CURRENT_BG_UNIT_LABEL_FONT = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.thin)
        static let BG_DELTA_LABEL_FONT = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
    }
    
    struct Size {
        static let LINE_CHART_LINE = CGFloat(3.0)
        static let LINE_CHART_REFERENCE_LINE = CGFloat(1.0)
        
    }
    
    struct LINE_CHART {
        static let RANGE_MAX = 300.0
        static let RANGE_MIN = 40.0
    }
    
    struct Text {
    }
    
    struct Segues {
    }
    
    struct KeychainKeys {
    }
    
    struct APIKeys {
    }
    
}
