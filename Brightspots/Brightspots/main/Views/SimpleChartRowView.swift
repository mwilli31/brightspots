// Created by Marli Oshlack on 10/14/18.
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


public class SimpleChartRowView: MDCCard {
    // MARK: Properties
    

    // MARK: Lifecycle
    
    public init() {
        super.init(frame: .zero)
        setUpViews()
        setupConstraints()
    }
    
    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var examples: Examples!
    var graphView: ScrollableGraphView!
    var graphConstraints = [NSLayoutConstraint]()
    
    private func setUpViews() {
//        self.frame = CGRect(x: 0, y: 0, width: 300, height: 600)
        setUpChartView()
    }
    
    private func setUpChartView() {
        examples = Examples()
        graphView = examples.createBlueOrangeGraph(self.frame)
        addSubview(graphView)
    }
    
    // MARK: Constraints
    
    private func setupConstraints() {
        
        self.graphView.translatesAutoresizingMaskIntoConstraints = false
        graphConstraints.removeAll()
        
        // Get the superview's layout
        let margins = self.layoutMarginsGuide
        
        // Pin the leading edge of myView to the margin's leading edge
        self.graphView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        
        // Pin the trailing edge of myView to the margin's trailing edge
        self.graphView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        // Give myView a 1:2 aspect ratio
        self.graphView.heightAnchor.constraint(equalTo: self.graphView.widthAnchor, multiplier: 1.0).isActive = true
        
        self.addConstraints(graphConstraints)
    }
    
}
