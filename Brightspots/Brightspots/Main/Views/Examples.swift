//
//  Examples.swift
//  Brightspots
//
//  Created by Michael Williams on 3/5/19.
//  Copyright © 2019 Michael Williams. All rights reserved.
//

import UIKit
import ScrollableGraphView

class Examples : ScrollableGraphViewDataSource {
    // MARK: Data Properties
    
    private var numberOfDataItems = 29
    
    // Data for graphs with a single plot
    private lazy var simpleLinePlotData: [Double] = self.generateRandomData(self.numberOfDataItems, max: 100, shouldIncludeOutliers: false)
    private lazy var darkLinePlotData: [Double] = self.generateRandomData(self.numberOfDataItems, max: 50, shouldIncludeOutliers: true)
    private lazy var dotPlotData: [Double] =  self.generateRandomData(self.numberOfDataItems, variance: 4, from: 25)
    private lazy var barPlotData: [Double] =  self.generateRandomData(self.numberOfDataItems, max: 100, shouldIncludeOutliers: false)
    private lazy var pinkLinePlotData: [Double] =  self.generateRandomData(self.numberOfDataItems, max: 100, shouldIncludeOutliers: false)
    
    // Data for graphs with multiple plots
    private lazy var blueLinePlotData: [Double] = self.generateRandomData(self.numberOfDataItems, max: 200)
    private lazy var orangeLinePlotData: [Double] =  self.generateRandomData(self.numberOfDataItems, max: 200, shouldIncludeOutliers: false)
    private lazy var rangeLinePlotData: [Double] =  self.generateRangeData(self.numberOfDataItems)
    
    // Labels for the x-axis
    
    private lazy var xAxisLabels: [String] =  self.generateSequentialLabels(self.numberOfDataItems, text: "FEB")
    
    // MARK: ScrollableGraphViewDataSource protocol
    // #########################################################
    
    // You would usually only have a couple of cases here, one for each
    // plot you want to display on the graph. However as this is showing
    // off many graphs with different plots, we are using one big switch
    // statement.
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        
        switch(plot.identifier) {
            
        // Data for the graphs with a single plot
        case "simple":
            return simpleLinePlotData[pointIndex]
        case "darkLine":
            return darkLinePlotData[pointIndex]
        case "darkLineDot":
            return darkLinePlotData[pointIndex]
        case "bar":
            return barPlotData[pointIndex]
        case "dot":
            return dotPlotData[pointIndex]
        case "pinkLine":
            return pinkLinePlotData[pointIndex]
            
        // Data for MULTI graphs
        case "multiBlue":
            return blueLinePlotData[pointIndex]
        case "multiBlueDot":
            return blueLinePlotData[pointIndex]
        case "multiOrange":
            return orangeLinePlotData[pointIndex]
        case "multiOrangeSquare":
            return orangeLinePlotData[pointIndex]
        case "range":
            return rangeLinePlotData[pointIndex]
            
        default:
            return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        // Ensure that you have a label to return for the index
        return xAxisLabels[pointIndex]
    }
    
    func numberOfPoints() -> Int {
        return numberOfDataItems
    }
    
    // MARK: Example Graphs
    // ##################################
    
    // The simplest kind of graph
    // A single line plot, with no range adaption when scrolling
    // No animations
    // min: 0
    // max: 100
    func createSimpleGraph(_ frame: CGRect) -> ScrollableGraphView {
        
        // Compose the graph view by creating a graph, then adding any plots
        // and reference lines before adding the graph to the view hierarchy.
        let graphView = ScrollableGraphView(frame: frame, dataSource: self)
        
        let linePlot = LinePlot(identifier: "simple") // Identifier should be unique for each plot.
        let referenceLines = ReferenceLines()
        
        graphView.addPlot(plot: linePlot)
        graphView.addReferenceLines(referenceLines: referenceLines)
        
        return graphView
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // Multi plot v1
    // min: 0
    // max: determined from active points
    // The max reference line will be the max of all visible points
    // Reference lines are placed relatively, at 0%, 20%, 40%, 60%, 80% and 100% of the max
    func createMultiPlotGraphOne(_ frame: CGRect) -> ScrollableGraphView {
        let graphView = ScrollableGraphView(frame: frame, dataSource: self)
        
        // Setup the first plot.
        let blueLinePlot = LinePlot(identifier: "multiBlue")
        
        blueLinePlot.lineColor = hexStringToUIColor(hex: "#16aafc")
        blueLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        // dots on the line
        let blueDotPlot = DotPlot(identifier: "multiBlueDot")
        blueDotPlot.dataPointType = ScrollableGraphViewDataPointType.circle
        blueDotPlot.dataPointSize = 5
        blueDotPlot.dataPointFillColor = hexStringToUIColor(hex: "#16aafc")
        
        blueDotPlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        // Setup the second plot.
        let orangeLinePlot = LinePlot(identifier: "multiOrange")
        
        orangeLinePlot.lineColor = hexStringToUIColor(hex: "#ff7d78")
        orangeLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        // squares on the line
        let orangeSquarePlot = DotPlot(identifier: "multiOrangeSquare")
        orangeSquarePlot.dataPointType = ScrollableGraphViewDataPointType.square
        orangeSquarePlot.dataPointSize = 5
        orangeSquarePlot.dataPointFillColor = hexStringToUIColor(hex: "#ff7d78")
        
        orangeSquarePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        // Setup the reference lines.
        let referenceLines = ReferenceLines()
        
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        referenceLines.referenceLineLabelColor = UIColor.white
        referenceLines.relativePositions = [0, 0.2, 0.4, 0.6, 0.8, 1]
        
        referenceLines.dataPointLabelColor = UIColor.white.withAlphaComponent(1)
        
        // Setup the graph
        graphView.backgroundFillColor = hexStringToUIColor(hex: "#333333")
        
        graphView.dataPointSpacing = 80
        
        graphView.shouldAnimateOnStartup = true
        graphView.shouldAdaptRange = true
        graphView.shouldRangeAlwaysStartAtZero = true
        
        // Add everything to the graph.
        graphView.addReferenceLines(referenceLines: referenceLines)
        graphView.addPlot(plot: blueLinePlot)
        graphView.addPlot(plot: blueDotPlot)
        graphView.addPlot(plot: orangeLinePlot)
        graphView.addPlot(plot: orangeSquarePlot)
        
        return graphView
    }
    
    // Multi plot v2
    // min: 0
    // max: determined from active points
    // The max reference line will be the max of all visible points
    func createMultiPlotGraphTwo(_ frame: CGRect) -> ScrollableGraphView {
        let graphView = ScrollableGraphView(frame: frame, dataSource: self)
        
        // Setup the line plot.
        let blueLinePlot = LinePlot(identifier: "multiBlue")
        
        blueLinePlot.lineWidth = 1
        blueLinePlot.lineColor = hexStringToUIColor(hex: "#16aafc")
        blueLinePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        blueLinePlot.shouldFill = true
        blueLinePlot.fillType = ScrollableGraphViewFillType.solid
        blueLinePlot.fillColor = hexStringToUIColor(hex: "#16aafc").withAlphaComponent(0.5)
        
        blueLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        // Setup the second line plot.
        let orangeLinePlot = LinePlot(identifier: "multiOrange")
        
        orangeLinePlot.lineWidth = 1
        orangeLinePlot.lineColor = hexStringToUIColor(hex: "#ff7d78")
        orangeLinePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        orangeLinePlot.shouldFill = true
        orangeLinePlot.fillType = ScrollableGraphViewFillType.solid
        orangeLinePlot.fillColor = hexStringToUIColor(hex: "#ff7d78").withAlphaComponent(0.5)
        
        orangeLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        // Setup the reference lines.
        let referenceLines = ReferenceLines()
        
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        referenceLines.referenceLineLabelColor = UIColor.white
        
        referenceLines.dataPointLabelColor = UIColor.white.withAlphaComponent(1)
        
        // Setup the graph
        graphView.backgroundFillColor = hexStringToUIColor(hex: "#333333")
        
        graphView.dataPointSpacing = 80
        graphView.shouldAnimateOnStartup = true
        graphView.shouldAdaptRange = true
        
        graphView.shouldRangeAlwaysStartAtZero = true
        
        // Add everything to the graph.
        graphView.addReferenceLines(referenceLines: referenceLines)
        graphView.addPlot(plot: blueLinePlot)
        graphView.addPlot(plot: orangeLinePlot)
        
        return graphView
    }
    
    // Reference lines are positioned absolutely. will appear at specified values on y axis
    func createDarkGraph(_ frame: CGRect) -> ScrollableGraphView {
        let graphView = ScrollableGraphView(frame: frame, dataSource: self)
        
        // Setup the line plot.
        let linePlot = LinePlot(identifier: "darkLine")
        
        linePlot.lineWidth = 1
        linePlot.lineColor = hexStringToUIColor(hex: "#777777")
        linePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        linePlot.shouldFill = true
        linePlot.fillType = ScrollableGraphViewFillType.gradient
        linePlot.fillGradientType = ScrollableGraphViewGradientType.linear
        linePlot.fillGradientStartColor = hexStringToUIColor(hex: "#555555")
        linePlot.fillGradientEndColor = hexStringToUIColor(hex: "#444444")
        
        linePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        let dotPlot = DotPlot(identifier: "darkLineDot") // Add dots as well.
        dotPlot.dataPointSize = 2
        dotPlot.dataPointFillColor = UIColor.white
        
        dotPlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        // Setup the reference lines.
        let referenceLines = ReferenceLines()
        
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        referenceLines.referenceLineLabelColor = UIColor.white
        
        referenceLines.positionType = .absolute
        // Reference lines will be shown at these values on the y-axis.
        referenceLines.absolutePositions = [10, 20, 25, 30]
        referenceLines.includeMinMax = false
        
        referenceLines.dataPointLabelColor = UIColor.white.withAlphaComponent(0.5)
        
        // Setup the graph
        graphView.backgroundFillColor = hexStringToUIColor(hex: "#333333")
        graphView.dataPointSpacing = 80
        
        graphView.shouldAnimateOnStartup = true
        graphView.shouldAdaptRange = true
        graphView.shouldRangeAlwaysStartAtZero = true
        
        graphView.rangeMax = 50
        
        // Add everything to the graph.
        graphView.addReferenceLines(referenceLines: referenceLines)
        graphView.addPlot(plot: linePlot)
        graphView.addPlot(plot: dotPlot)
        
        return graphView
    }
    
    // min: 0
    // max: 100
    // Will not adapt min and max reference lines to range of visible points
    func createBarGraph(_ frame: CGRect) -> ScrollableGraphView {
        
        let graphView = ScrollableGraphView(frame: frame, dataSource: self)
        
        // Setup the plot
        let barPlot = BarPlot(identifier: "bar")
        
        barPlot.barWidth = 25
        barPlot.barLineWidth = 1
        barPlot.barLineColor = hexStringToUIColor(hex: "#777777")
        barPlot.barColor = hexStringToUIColor(hex: "#555555")
        
        barPlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        barPlot.animationDuration = 1.5
        
        // Setup the reference lines
        let referenceLines = ReferenceLines()
        
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        referenceLines.referenceLineLabelColor = UIColor.white
        
        referenceLines.dataPointLabelColor = UIColor.white.withAlphaComponent(0.5)
        
        // Setup the graph
        graphView.backgroundFillColor = hexStringToUIColor(hex: "#333333")
        
        graphView.shouldAnimateOnStartup = true
        
        graphView.rangeMax = 100
        graphView.rangeMin = 0
        
        // Add everything
        graphView.addPlot(plot: barPlot)
        graphView.addReferenceLines(referenceLines: referenceLines)
        return graphView
    }
    
    // min: 0
    // max 50
    // Will not adapt min and max reference lines to range of visible points
    // no animations
    func createDotGraph(_ frame: CGRect) -> ScrollableGraphView {
        
        let graphView = ScrollableGraphView(frame: frame, dataSource: self)
        
        // Setup the plot
        let plot = DotPlot(identifier: "dot")
        
        plot.dataPointSize = 5
        plot.dataPointFillColor = UIColor.white
        
        // Setup the reference lines
        let referenceLines = ReferenceLines()
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 10)
        referenceLines.referenceLineColor = UIColor.white.withAlphaComponent(0.5)
        referenceLines.referenceLineLabelColor = UIColor.white
        referenceLines.referenceLinePosition = ScrollableGraphViewReferenceLinePosition.both
        
        referenceLines.shouldShowLabels = false
        
        // Setup the graph
        graphView.backgroundFillColor = hexStringToUIColor(hex: "#00BFFF")
        graphView.shouldAdaptRange = false
        graphView.shouldAnimateOnAdapt = false
        graphView.shouldAnimateOnStartup = false
        
        graphView.dataPointSpacing = 25
        graphView.rangeMax = 50
        graphView.rangeMin = 0
        
        // Add everything
        graphView.addPlot(plot: plot)
        graphView.addReferenceLines(referenceLines: referenceLines)
        return graphView
    }
    
    // min: min of visible points
    // max: max of visible points
    // Will adapt min and max reference lines to range of visible points
    func createPinkGraph(_ frame: CGRect) -> ScrollableGraphView {
        
        let graphView = ScrollableGraphView(frame: frame, dataSource: self)
        
        // Setup the plot
        let linePlot = LinePlot(identifier: "pinkLine")
        
        linePlot.lineColor = UIColor.clear
        linePlot.shouldFill = true
        linePlot.fillColor = hexStringToUIColor(hex: "#FF0080")
        
        // Setup the reference lines
        let referenceLines = ReferenceLines()
        
        referenceLines.referenceLineThickness = 1
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 10)
        referenceLines.referenceLineColor = UIColor.white.withAlphaComponent(0.5)
        referenceLines.referenceLineLabelColor = UIColor.white
        referenceLines.referenceLinePosition = ScrollableGraphViewReferenceLinePosition.both
        
        referenceLines.dataPointLabelFont = UIFont.boldSystemFont(ofSize: 10)
        referenceLines.dataPointLabelColor = UIColor.white
        referenceLines.dataPointLabelsSparsity = 3
        
        // Setup the graph
        graphView.backgroundFillColor = hexStringToUIColor(hex: "#222222")
        
        graphView.dataPointSpacing = 60
        graphView.shouldAdaptRange = true
        
        // Add everything
        graphView.addPlot(plot: linePlot)
        graphView.addReferenceLines(referenceLines: referenceLines)
        return graphView
    }
    
    //
    func createBlueOrangeGraph(_ frame: CGRect) -> ScrollableGraphView {
        let graphView = ScrollableGraphView(frame: frame, dataSource: self)
        // Setup the first line plot.
        let blueLinePlot = LinePlot(identifier: "multiBlue")
        
        blueLinePlot.lineWidth = 5
        blueLinePlot.lineColor = hexStringToUIColor(hex: "#16aafc")
        blueLinePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        blueLinePlot.shouldFill = false
        blueLinePlot.fillType = ScrollableGraphViewFillType.solid
        blueLinePlot.fillColor = hexStringToUIColor(hex: "#16aafc").withAlphaComponent(0.5)
        
        blueLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        // Setup the second line plot.
        let orangeLinePlot = LinePlot(identifier: "multiOrange")
        
        orangeLinePlot.lineWidth = 5
        orangeLinePlot.lineColor = hexStringToUIColor(hex: "#ff7d78")
        orangeLinePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        orangeLinePlot.shouldFill = false
        orangeLinePlot.fillType = ScrollableGraphViewFillType.solid
        orangeLinePlot.fillColor = hexStringToUIColor(hex: "#ff7d78").withAlphaComponent(0.5)
        
        orangeLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        
        let rangeLinePlot = LinePlot(identifier: "range")
        
        rangeLinePlot.lineWidth = 40
        rangeLinePlot.lineColor = UIColor.white.withAlphaComponent(0.3)
        rangeLinePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        rangeLinePlot.shouldFill = false
        rangeLinePlot.fillType = ScrollableGraphViewFillType.gradient
        rangeLinePlot.fillColor = UIColor.white.withAlphaComponent(0.1)
        
        // Customise the reference lines.
        let referenceLines = ReferenceLines()
        
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.referenceLineColor = UIColor.black.withAlphaComponent(0.2)
        referenceLines.referenceLineLabelColor = UIColor.black
        
        referenceLines.dataPointLabelColor = UIColor.black.withAlphaComponent(1)
        
        let referenceLinesRange = ReferenceLines()
        
        referenceLinesRange.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 12)
        referenceLinesRange.referenceLineColor = UIColor.gray.withAlphaComponent(0.8)
        referenceLinesRange.referenceLineThickness = 1
        referenceLinesRange.referenceLineLabelColor = UIColor.white
//        referenceLinesRange.positionType = ReferenceLinePositioningType.absolute
//        referenceLinesRange.absolutePositions = [60,120]
        
        // All other graph customisation is done in Interface Builder,
        // e.g, the background colour would be set in interface builder rather than in code.
        graphView.backgroundFillColor = hexStringToUIColor(hex: "#6200EE")
        graphView.shouldAdaptRange = false
        graphView.shouldRangeAlwaysStartAtZero = true
        graphView.rangeMax = 400
        graphView.topMargin = 10.0
        graphView.bottomMargin = 10.0
        
        // Add everything to the graph.
//        graphView.addReferenceLines(referenceLines: referenceLines)
        graphView.addReferenceLines(referenceLines: referenceLinesRange)
        graphView.addPlot(plot: rangeLinePlot)
        graphView.addPlot(plot: blueLinePlot)
        graphView.addPlot(plot: orangeLinePlot)
        return graphView
    }
    
    // MARK: Data Generation
    
    func reload() {
        // Currently changing the number of data items is not supported.
        // It is only possible to change the the actual values of the data before reloading.
        // numberOfDataItems = 30
        
        // data for graphs with a single plot
        simpleLinePlotData = self.generateRandomData(self.numberOfDataItems, max: 100, shouldIncludeOutliers: false)
        darkLinePlotData = self.generateRandomData(self.numberOfDataItems, max: 50, shouldIncludeOutliers: true)
        dotPlotData = self.generateRandomData(self.numberOfDataItems, variance: 4, from: 25)
        barPlotData = self.generateRandomData(self.numberOfDataItems, max: 100, shouldIncludeOutliers: false)
        pinkLinePlotData = self.generateRandomData(self.numberOfDataItems, max: 100, shouldIncludeOutliers: false)
        
        // data for graphs with multiple plots
        blueLinePlotData = self.generateRandomData(self.numberOfDataItems, max: 50)
        orangeLinePlotData = self.generateRandomData(self.numberOfDataItems, max: 40, shouldIncludeOutliers: false)
        
        // update labels
        xAxisLabels = self.generateSequentialLabels(self.numberOfDataItems, text: "MAR")
    }
    
    private func generateRandomData(_ numberOfItems: Int, max: Double, shouldIncludeOutliers: Bool = true) -> [Double] {
        var data = [Double]()
        for _ in 0 ..< numberOfItems {
            var randomNumber = Double(arc4random()).truncatingRemainder(dividingBy: max)
            
            if(shouldIncludeOutliers) {
                if(arc4random() % 100 < 10) {
                    randomNumber *= 3
                }
            }
            
            data.append(randomNumber)
        }
        return data
    }
    
    private func generateRangeData(_ numberOfItems: Int) -> [Double] {
        var data = [Double]()
        for _ in 0 ..< numberOfItems {
            let randomNumber = Double(100)
            
            data.append(randomNumber)
        }
        return data
    }
    
    private func generateRandomData(_ numberOfItems: Int, variance: Double, from: Double) -> [Double] {
        
        var data = [Double]()
        for _ in 0 ..< numberOfItems {
            
            let randomVariance = Double(arc4random()).truncatingRemainder(dividingBy: variance)
            var randomNumber = from
            
            if(arc4random() % 100 < 50) {
                randomNumber += randomVariance
            }
            else {
                randomNumber -= randomVariance
            }
            
            data.append(randomNumber)
        }
        return data
    }
    
    private func generateSequentialLabels(_ numberOfItems: Int, text: String) -> [String] {
        var labels = [String]()
        for i in 0 ..< numberOfItems {
            labels.append("\(text) \(i+1)")
        }
        return labels
    }
}
