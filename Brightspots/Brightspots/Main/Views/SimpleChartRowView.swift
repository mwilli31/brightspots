// Based on work by Marli Oshlack on 10/14/18.
// Copyright 2018 Airbnb, Inc.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit
import ScrollableGraphView
import MaterialComponents.MaterialCards
import MaterialComponents.MaterialCards_ColorThemer

public class SimpleChartRowView: MDCCard {
    // MARK: Properties
    let colorScheme = MDCSemanticColorScheme()

    // MARK: Lifecycle
    
    public init() {
        super.init(frame: .zero)
        MDCCardsColorThemer.applySemanticColorScheme(mainColorScheme, to: self)
        setUpViews()
        setupConstraints()
    }
    
    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var chart: SimpleChart!
    var graphView: ScrollableGraphView!
    var graphConstraints = [NSLayoutConstraint]()
    var currentBGLabel = UILabel()
    var currentBGLabelConstraints = [NSLayoutConstraint]()
    var currentBGUnitLabel = UILabel()
    var currentBGUnitLabelConstraints = [NSLayoutConstraint]()
    var bgDeltaLabel = UILabel()
    var bgDeltaLabelConstraints = [NSLayoutConstraint]()
    var bgDeltaArrowLabel = UILabel()
    var bgDeltaArrowLabelConstraints = [NSLayoutConstraint]()
    
    private func setUpViews() {
        setUpLabel()
        setUpChartView()
    }
    
    private func setupConstraints() {
        setupLabelConstraints()
        setupChartViewContraints()
    }

    private func setUpLabel() {
        currentBGLabel.textAlignment = NSTextAlignment.left
        currentBGLabel.font = Constants.Font.CURRENT_BG_LABEL_FONT
        currentBGLabel.text = "---"
        addSubview(currentBGLabel)
        
        currentBGUnitLabel.textAlignment = NSTextAlignment.left
        currentBGUnitLabel.font = Constants.Font.CURRENT_BG_UNIT_LABEL_FONT
        currentBGUnitLabel.text = "mg/dl"
        currentBGUnitLabel.textColor = mainColorScheme.onSurfaceColor
        addSubview(currentBGUnitLabel)

        bgDeltaLabel.textAlignment = NSTextAlignment.left
        bgDeltaLabel.font = Constants.Font.BG_DELTA_LABEL_FONT
        bgDeltaLabel.text = "---"
        addSubview(bgDeltaLabel)
        
        bgDeltaArrowLabel.textAlignment = NSTextAlignment.left
        bgDeltaArrowLabel.font = Constants.Font.BG_DELTA_LABEL_FONT
        bgDeltaArrowLabel.text = "-"
        addSubview(bgDeltaArrowLabel)
    }
    
    private func setUpChartView() {
        chart = SimpleChart()
        graphView = chart.createSimpleGraph(self.frame)
        addSubview(graphView)
    }
    
    //data reloading
    
    func paintCurrentBgData(currentNightscoutData : NightscoutData) {
        
        DispatchQueue.main.async(execute: {
            if currentNightscoutData.sgv == "---" {
                self.currentBGLabel.text = "---"
            } else {
                self.currentBGLabel.text = currentNightscoutData.sgv
            }
            self.currentBGLabel.textColor = bloodGlucoseColorScheme.getBgColor(currentNightscoutData.sgv)
            
            self.bgDeltaLabel.text = currentNightscoutData.bgdeltaString.cleanFloatValue
            self.bgDeltaArrowLabel.text = currentNightscoutData.bgdeltaArrow
            self.bgDeltaLabel.textColor = bloodGlucoseColorScheme.getDeltaLabelColor(NSNumber(value: currentNightscoutData.bgdelta))
            self.bgDeltaArrowLabel.textColor = bloodGlucoseColorScheme.getDeltaLabelColor(NSNumber(value: currentNightscoutData.bgdelta))
//
//            self.lastUpdateLabel.text = currentNightscoutData.timeString
//            self.lastUpdateLabel.textColor = UIColorChanger.getTimeLabelColor(currentNightscoutData.time)
//
//            self.batteryLabel.text = currentNightscoutData.battery
//            self.iobLabel.text = currentNightscoutData.iob
//
//            self.showHideRawBGPanel(currentNightscoutData)
//            self.rawValuesPanel.label.text = currentNightscoutData.noise
//            self.rawValuesPanel.highlightedLabel.text = currentNightscoutData.rawbg
        })
    }
    
    func reloadData(fromNightscout:[BloodSugar], prediction:[BloodSugar], yesterday:[BloodSugar]) {
        //prepare data for chart
        //initialize size of array
        var chartArray = Array(repeating: 0.0, count: chart.numberOfPoints())
        var chartArray2 = Array(repeating: 0.0, count: chart.numberOfPoints())
        var chartArray3 = Array(repeating: 0.0, count: chart.numberOfPoints())
        var arrIndex: Int
        var date: Date
        let calendar = Calendar.current
        var hour: Int
        var min: Int
        for i in 0 ..< fromNightscout.count {
            //find how the timestamp fits in the chartArray index
            date = fromNightscout[i].date
            hour = calendar.component(.hour, from: date)
            min = calendar.component(.minute, from: date)
            arrIndex = (hour * 60 + min) / 5
            chartArray.insert(Double(fromNightscout[i].value), at: arrIndex)
        }
        for i in 0 ..< prediction.count {
            //find how the timestamp fits in the chartArray index
            date = prediction[i].date
            hour = calendar.component(.hour, from: date)
            min = calendar.component(.minute, from: date)
            arrIndex = (hour * 60 + min) / 5
            chartArray2.insert(Double(prediction[i].value), at: arrIndex)
        }
//        for i in 0 ..< yesterday.count {
//            //find how the timestamp fits in the chartArray index
//            date = yesterday[i].date
//            hour = calendar.component(.hour, from: date)
//            min = calendar.component(.minute, from: date)
//            arrIndex = (hour * 60 + min) / 5
//            chartArray3.insert(Double(yesterday[i].value), at: arrIndex)
//        }
        //have the chart reload
        chart.reload(data: chartArray, prediction: chartArray2, yesterday: chartArray3)
        graphView.reload()
    }
    
    // MARK: Constraints
    
    private func setupLabelConstraints() {
        
        // Get the superview's layout
        let margins = self.layoutMarginsGuide
        
        self.currentBGLabel.translatesAutoresizingMaskIntoConstraints = false
        currentBGLabelConstraints.removeAll()
        self.currentBGLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 5).isActive = true
        // Pin the leading edge of myView to the margin's leading edge
        self.currentBGLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        // Pin the trailing edge of myView to the margin's trailing edge
//        self.currentBGLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        self.addConstraints(currentBGLabelConstraints)

        self.currentBGUnitLabel.translatesAutoresizingMaskIntoConstraints = false
        currentBGUnitLabelConstraints.removeAll()
        self.currentBGUnitLabel.bottomAnchor.constraint(equalTo: currentBGLabel.bottomAnchor, constant: -5).isActive = true
        // Pin the leading edge of myView to the margin's leading edge
        self.currentBGUnitLabel.leadingAnchor.constraint(equalTo: self.currentBGLabel.trailingAnchor, constant: 10).isActive = true
        // Pin the trailing edge of myView to the margin's trailing edge
        //        self.bgDeltaLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        self.addConstraints(currentBGUnitLabelConstraints)
        
        self.bgDeltaLabel.translatesAutoresizingMaskIntoConstraints = false
        bgDeltaLabelConstraints.removeAll()
        self.bgDeltaLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 5).isActive = true
        // Pin the leading edge of myView to the margin's leading edge
        self.bgDeltaLabel.leadingAnchor.constraint(equalTo: self.currentBGUnitLabel.trailingAnchor, constant: 20).isActive = true
        // Pin the trailing edge of myView to the margin's trailing edge
//        self.bgDeltaLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        self.addConstraints(bgDeltaLabelConstraints)
        
        self.bgDeltaArrowLabel.translatesAutoresizingMaskIntoConstraints = false
        bgDeltaArrowLabelConstraints.removeAll()
        self.bgDeltaArrowLabel.bottomAnchor.constraint(equalTo: currentBGLabel.bottomAnchor, constant: -5).isActive = true
        // Pin the leading edge of myView to the margin's leading edge
        self.bgDeltaArrowLabel.leadingAnchor.constraint(equalTo: self.currentBGUnitLabel.trailingAnchor, constant: 20).isActive = true
        // Pin the trailing edge of myView to the margin's trailing edge
        //        self.bgDeltaLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        self.addConstraints(bgDeltaArrowLabelConstraints)
    }
    
    private func setupChartViewContraints() {
        
        // Get the superview's layout
        let margins = self.layoutMarginsGuide
        
        self.graphView.translatesAutoresizingMaskIntoConstraints = false
        graphConstraints.removeAll()
        
        // Pin the leading edge of myView to the margin's leading edge
        self.graphView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 65).isActive = true

        self.graphView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        
        // Pin the trailing edge of myView to the margin's trailing edge
        self.graphView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        // Give myView a 1:2 aspect ratio
        self.graphView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 5).isActive = true

        self.addConstraints(graphConstraints)
    }
    
    
}
