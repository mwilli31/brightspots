//
//  MainTabBarViewController.swift
//  Brightspots
//
//  Created by Michael Williams on 3/3/19.
//  Copyright © 2019 Michael Williams. All rights reserved.
//

import UIKit
import Auth0

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //create views an intialize their tabs
        let homeVC = HomeViewController()
        homeVC.title = "Home"
        homeVC.view.backgroundColor = UIColor.white
        
        let networkVC = NetworkViewController()
        networkVC.title = "Network"
        networkVC.view.backgroundColor = UIColor.white
        
        let reportsVC = ReportsViewController()
        reportsVC.title = "Report"
        reportsVC.view.backgroundColor = UIColor.white
        
        let logVC = LogViewController()
        logVC.title = "Log"
        logVC.view.backgroundColor = UIColor.white
        
        homeVC.tabBarItem = UITabBarItem()
        homeVC.tabBarItem.image = UIImage.fontAwesomeIcon(name: .home, style: .solid, textColor: .gray, size: CGSize(width: 35, height: 35))
        homeVC.tabBarItem.title = "Home"
        
        networkVC.tabBarItem = UITabBarItem()
        networkVC.tabBarItem.image = UIImage.fontAwesomeIcon(name: .users, style: .solid, textColor: .gray, size: CGSize(width: 35, height: 35))
        networkVC.tabBarItem.title = "Network"
        
        reportsVC.tabBarItem = UITabBarItem()
        reportsVC.tabBarItem.image = UIImage.fontAwesomeIcon(name: .chartLine, style: .solid, textColor: .gray, size: CGSize(width: 35, height: 35))
        reportsVC.tabBarItem.title = "Reports"
        
        logVC.tabBarItem = UITabBarItem()
        logVC.tabBarItem.image = UIImage.fontAwesomeIcon(name: .ellipsisV, style: .solid, textColor: .gray, size: CGSize(width: 35, height: 35))
        logVC.tabBarItem.title = "Log"
        
        let controllers = [homeVC, networkVC, reportsVC, logVC]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func pushToNextVC() {
        let newVC = UIViewController()
        newVC.view.backgroundColor = UIColor.red
        self.navigationController?.pushViewController(newVC, animated:
            true)
    }

}
