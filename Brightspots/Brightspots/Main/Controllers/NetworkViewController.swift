//
//  SecondViewController.swift
//  Brightspots
//
//  Created by Michael Williams on 3/3/19.
//  Copyright © 2019 Michael Williams. All rights reserved.
//

import UIKit

class NetworkViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        NetworkTabBarItem.image = UIImage.fontAwesomeIcon(name: .users, style: .solid, textColor: .gray, size: CGSize(width: 35, height: 35))
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

