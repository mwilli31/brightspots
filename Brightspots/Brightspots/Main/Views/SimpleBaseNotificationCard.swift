//
//  SimpleBaseNotificationCard.swift
//  Brightspots
//
//  Created by Michael Williams on 6/23/19.
//  Copyright © 2019 Michael Williams. All rights reserved.
//

import UIKit
import ScrollableGraphView
import MaterialComponents.MaterialCards
import MaterialComponents.MaterialCards_ColorThemer

public class SimpleBaseNotificationCard: MDCCard {
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
    }
    
    private func setupConstraints() {
        setupLabelConstraints()
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
    
    
    func setLabels(title: String) {
        
        
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
    
}
