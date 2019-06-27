//
//  FirstViewController.swift
//  Brightspots
//
//  Created by Michael Williams on 3/3/19.
//  Copyright © 2019 Michael Williams. All rights reserved.
//

import UIKit
import AloeStackView
import FontAwesome_swift

class HomeViewController: UIViewController {

    let vc1 = TrackViewController()
    let vc2 = ScheduleViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let segmentController = UISegmentedControl()
        segmentController.frame = CGRect(x: 10, y: self.view.frame.minY + 35, width: 200, height: 40)
        //segment frame size
        segmentController.insertSegment(withTitle: "Track", at: 0, animated: false)
        //inserting new segment at index 0
        segmentController.insertSegment(withTitle: "Schedule", at: 1, animated: false)

        //setting the background color of the segment controller
        segmentController.selectedSegmentIndex = 0
        let font = UIFont.systemFont(ofSize: 18)
        segmentController.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        segmentController.tintColor = mainColorScheme.surfaceColor
        //setting the segment which is initially selected
        segmentController.addTarget(self, action: #selector(selected), for: .valueChanged)
        //calling the selector method
        self.view.addSubview(segmentController)
        //adding the view as subview of the segment comntroller w.r.t. main view controller
        addChild(vc2)
        vc2.view.frame = CGRect(x: 0, y: self.view.frame.minY + 75, width: self.view.frame.width, height: self.view.frame.height - 75)
        self.view.addSubview(vc2.view)
        vc2.didMove(toParent: self)
        
        addChild(vc1)
        vc1.view.frame = CGRect(x: 0, y: self.view.frame.minY + 75, width: self.view.frame.width, height: self.view.frame.height - 75)
        self.view.addSubview(vc1.view)
        vc1.didMove(toParent: self)
        
    }
    
    @objc func selected(sender : UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            vc1.view.isHidden = false
            vc2.view.isHidden = true
        } else if sender.selectedSegmentIndex == 1 {
            vc1.view.isHidden = true
            vc2.view.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }

}
