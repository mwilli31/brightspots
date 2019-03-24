//
//  TrackViewController.swift
//  Brightspots
//
//  Created by Michael Williams on 3/4/19.
//  Copyright © 2019 Michael Williams. All rights reserved.
//

import UIKit
import AloeStackView
import MaterialComponents.MaterialCards

class TrackViewController: UIViewController {

    let stackView = AloeStackView()
    let simpleChartRow = SimpleChartRowView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        setUpSelf()
        setUpStackView()
        setUpRows()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    // MARK: Private
    private func setUpSelf() {
        stackView.frame = CGRect(x: 0, y: self.view.frame.minY, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(stackView)    }
    
    private func setUpStackView() {
        stackView.automaticallyHidesLastSeparator = true
    }
    
    private func setUpRows() {
        setUpChartRow()
    }
    
    private func setUpDescriptionRow() {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.text = "This simple app shows some ways you can use AloeStackView to lay out a screen in your app."
        stackView.addRow(label)
    }
    
    private func setUpChartRow() {
        loadAndPaintChartData(forceRepaint: false)
        loadAndPaintCurrentBgData()
        stackView.addRow(simpleChartRow)
        simpleChartRow.heightAnchor.constraint(equalTo: simpleChartRow.widthAnchor, multiplier: 1.3).isActive = true
//        stackView.setTapHandler(forRow: simpleChartRow) { [weak self] _ in
//            guard let self = self else { return }
////            self.loadAndPaintChartData(forceRepaint: false)
//        }
    }
    
    
    // MARK: Nightscout
    
    fileprivate func loadAndPaintCurrentBgData() {
        
        let currentNightscoutData = NightscoutCacheService.singleton.loadCurrentNightscoutData { [unowned self] result in
            
            guard let result = result else {
                return
            }
            
            switch result {
            case .error(let error):
                print(error)
            case .data(let newNightscoutData):
                self.simpleChartRow.paintCurrentBgData(currentNightscoutData: newNightscoutData)
            }
        }
        
        self.simpleChartRow.paintCurrentBgData(currentNightscoutData: currentNightscoutData)
    }
    
    fileprivate func loadAndPaintChartData(forceRepaint : Bool) {
        
        let newCachedTodaysBgValues = NightscoutCacheService.singleton.loadTodaysData { [unowned self] result in
            guard let result = result else { return }
            
            if case .data(let newTodaysData) = result {
                let cachedYesterdaysData = NightscoutCacheService.singleton.getYesterdaysBgData()
                self.paintChartData(todaysData: newTodaysData, yesterdaysData: cachedYesterdaysData)
            }
        }
        
        let newCachedYesterdaysBgValues = NightscoutCacheService.singleton.loadYesterdaysData { [unowned self] result in
            guard let result = result else { return }
            
            if case .data(let newYesterdaysData) = result {
                let cachedTodaysBgData = NightscoutCacheService.singleton.getTodaysBgData()
                self.paintChartData(todaysData: cachedTodaysBgData, yesterdaysData: newYesterdaysData)
            }
        }
        
        // this does a fast paint of eventually cached data
        if forceRepaint ||
            NightscoutCacheService.singleton.valuesChanged() {
            
            paintChartData(todaysData: newCachedTodaysBgValues, yesterdaysData: newCachedYesterdaysBgValues)
        }
    }
    
    fileprivate func paintChartData(todaysData : [BloodSugar], yesterdaysData : [BloodSugar]) {
        
        _ = todaysData + PredictionService.singleton.nextHourGapped
        
        self.simpleChartRow.reloadData(fromNightscout: todaysData)

    }
}
