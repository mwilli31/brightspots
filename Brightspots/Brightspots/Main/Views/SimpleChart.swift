//
//  Examples.swift
//  Brightspots
//
//  Created by Michael Williams on 3/5/19.
//  Copyright © 2019 Michael Williams. All rights reserved.
//

import UIKit
import ScrollableGraphView

class SimpleChart : ScrollableGraphViewDataSource {
    // MARK: Data Properties
    
    private var numberOfDataItems = ((24*60)/5 + 1)
//    private var numberOfDataItems = 0
    // Labels for the x-axis
    private lazy var xAxisLabels: [String] =  self.generateTimeLabels()
    
    // Test Data for graphs with multiple plots
    private lazy var blueLinePlotData: [Double] = self.generateRandomData(numberOfDataItems, variance: 100.0, from: 160.0)
    // Test Data for graphs with multiple plots
    private lazy var predLinePlotData: [Double] = self.generateRandomData(numberOfDataItems, variance: 100.0, from: 160.0)
    private lazy var yesterdayLinePlotData: [Double] = self.generateRandomData(numberOfDataItems, variance: 100.0, from: 160.0)

    private lazy var rangeLinePlotData: [Double] =  self.generateRangeData(self.numberOfDataItems)
    private lazy var bigRangeLinePlotData: [Double] =  self.generateBigRangeData(self.numberOfDataItems)
    
    // MARK: ScrollableGraphViewDataSource protocol
    // #########################################################
    
    // You would usually only have a couple of cases here, one for each
    // plot you want to display on the graph. However as this is showing
    // off many graphs with different plots, we are using one big switch
    // statement.
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        
        switch(plot.identifier) {
            
        // Data for graphs
        case "multiBlue":
            return blueLinePlotData[pointIndex]
        case "prediction":
            return predLinePlotData[pointIndex]
        case "yesterday":
            return yesterdayLinePlotData[pointIndex]
        case "range":
            return rangeLinePlotData[pointIndex]
        case "bigRange":
            return bigRangeLinePlotData[pointIndex]
            
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
    
    // MARK: Graph
    // ##################################
    
    //
    func createSimpleGraph(_ frame: CGRect) -> ScrollableGraphView {
        //number of ms in a day
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let min = calendar.component(.minute, from: date)
        let interval = 5
        let intervals = 60 / interval  //every 5 minutes
        numberOfDataItems = (min/interval) + ((hour+1) * intervals)
        
        let graphView = ScrollableGraphView(frame: frame, dataSource: self)
        // Setup the first line plot.
        let blueLinePlot = DotPlot(identifier: "multiBlue")
        blueLinePlot.dataPointSize = Constants.Size.LINE_CHART_LINE
        blueLinePlot.dataPointFillColor = chartColorScheme.primaryColor
        blueLinePlot.dataPointType = ScrollableGraphViewDataPointType.circle
        blueLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        let predLinePlot = DotPlot(identifier: "prediction")
        predLinePlot.dataPointSize = Constants.Size.LINE_CHART_LINE_PRED
        predLinePlot.dataPointFillColor = chartColorScheme.secondaryColor.withAlphaComponent(0.7)
        predLinePlot.dataPointType = ScrollableGraphViewDataPointType.circle
        predLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
//        let yesterdayLinePlot = DotPlot(identifier: "yesterday")
//        yesterdayLinePlot.dataPointSize = Constants.Size.LINE_CHART_LINE_PRED
//        yesterdayLinePlot.dataPointFillColor = chartColorScheme.primaryColorVariant.withAlphaComponent(0.5)
//        yesterdayLinePlot.dataPointType = ScrollableGraphViewDataPointType.circle
//        yesterdayLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        let mainRangeLinePlot = LinePlot(identifier: "range")
        
        mainRangeLinePlot.lineWidth = LINE_CHART_GLUCOSE_RANGE
        mainRangeLinePlot.lineColor = chartColorScheme.rangeLineColor
        mainRangeLinePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
//        mainRangeLinePlot.animationDuration = 0.001
        
        mainRangeLinePlot.shouldFill = false
        mainRangeLinePlot.fillType = ScrollableGraphViewFillType.gradient
        mainRangeLinePlot.fillColor = .white
        
        let bigRangeLinePlot = LinePlot(identifier: "bigRange")
        
        bigRangeLinePlot.lineWidth = LINE_CHART_BIG_GLUCOSE_RANGE
        bigRangeLinePlot.lineColor = chartColorScheme.bigRangeLineColor
        bigRangeLinePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        bigRangeLinePlot.shouldFill = false
        bigRangeLinePlot.fillType = ScrollableGraphViewFillType.gradient
        bigRangeLinePlot.fillColor = .white
        
        let referenceLinesRange = ReferenceLines()
        referenceLinesRange.referenceLineLabelFont = Constants.Font.LINE_CHART_LABEL_FONT
        referenceLinesRange.referenceLineColor = chartColorScheme.referenceLineColor
        referenceLinesRange.referenceLineThickness = Constants.Size.LINE_CHART_REFERENCE_LINE
        referenceLinesRange.referenceLineLabelColor = chartColorScheme.onSurfaceColor
        referenceLinesRange.dataPointLabelColor = chartColorScheme.onSurfaceColor
        referenceLinesRange.positionType = ReferenceLinePositioningType.absolute
        referenceLinesRange.absolutePositions = [70,80,120,200]
        referenceLinesRange.dataPointLabelTopMargin = 20.0
        
        referenceLinesRange.dataPointLabelsSparsity = 12
        referenceLinesRange.dataPointLabelFont = Constants.Font.LINE_CHART_LABEL_FONT
        
        // All other graph customisation is done in Interface Builder,
        // e.g, the background colour would be set in interface builder rather than in code.
        graphView.backgroundFillColor = chartColorScheme.surfaceColor
        graphView.shouldAdaptRange = false
        graphView.shouldRangeAlwaysStartAtZero = false
        graphView.rangeMin = Constants.LINE_CHART.RANGE_MIN
        graphView.rangeMax = Constants.LINE_CHART.RANGE_MAX
        graphView.topMargin = 10.0
        graphView.bottomMargin = 10.0
        graphView.dataPointSpacing = 10.0
        graphView.rightmostPointPadding = 50.0
        graphView.direction = ScrollableGraphViewDirection.rightToLeft
        graphView.shouldAnimateOnStartup = false
        
        //generate static data
        rangeLinePlotData =  self.generateRangeData(self.numberOfDataItems)
        bigRangeLinePlotData =  self.generateBigRangeData(self.numberOfDataItems)
        
        // Add everything to the graph.
        graphView.addReferenceLines(referenceLines: referenceLinesRange)
        graphView.addPlot(plot: bigRangeLinePlot)
        graphView.addPlot(plot: mainRangeLinePlot)
        graphView.addPlot(plot: predLinePlot)
//        graphView.addPlot(plot: yesterdayLinePlot)
        graphView.addPlot(plot: blueLinePlot)
        return graphView
    }
    
    // MARK: Data Generation
    
    private func generateRangeData(_ numberOfItems: Int) -> [Double] {
        return Array(repeating: Double(LINE_CHART_GLUCOSE_MID), count: numberOfItems)
    }
    
    private func generateBigRangeData(_ numberOfItems: Int) -> [Double] {
        return Array(repeating: Double(LINE_CHART_BIG_GLUCOSE_MID), count: numberOfItems)
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
    
    private func generateTimeLabels() -> [String] {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)

        //always current days hours
        var labels = [String]()
        for i in 0 ..< hour+2 {
            print(i)
            if(i != hour) {
                for j in 0 ..< 1 {
                    labels.append("\(i):0\(j*5)")
                }
                for k in 1 ..< 12 {
                    labels.append("\(i):\(k*5)")
                }
            } else {
                labels.append("\(i):00")
            }
        }

        return labels
    }
    
    func reload(data: [Double], prediction: [Double], yesterday: [Double]) {
        // Currently changing the number of data items is not supported.
        // It is only possible to change the the actual values of the data before reloading.
        // numberOfDataItems = 30
        
        // Labels for the x-axis
        xAxisLabels =  self.generateTimeLabels()
        
        // Test Data for graphs with multiple plots
        blueLinePlotData = data
        predLinePlotData = prediction
//        yesterdayLinePlotData = yesterday
    }
}
