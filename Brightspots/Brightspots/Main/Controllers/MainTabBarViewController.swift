//
//  MainTabBarViewController.swift
//  Brightspots
//
//  Created by Michael Williams on 3/3/19.
//  Copyright © 2019 Michael Williams. All rights reserved.
//

import UIKit
import Auth0

class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //create views an intialize their tabs
        let homeVC = HomeViewController()
        homeVC.title = "Home"
        homeVC.view.backgroundColor = mainColorScheme.backgroundColor
        
        let networkVC = NetworkViewController()
        networkVC.title = "Network"
        networkVC.view.backgroundColor = mainColorScheme.backgroundColor
        
        let reportsVC = ReportsViewController()
        reportsVC.title = "Report"
        reportsVC.view.backgroundColor = mainColorScheme.backgroundColor
        
        let logVC = LogViewController()
        logVC.title = "Log"
        logVC.view.backgroundColor = mainColorScheme.backgroundColor
        
        homeVC.tabBarItem = UITabBarItem()
        homeVC.tabBarItem.image = UIImage.fontAwesomeIcon(name: .home, style: .solid, textColor: mainColorScheme.tabBarIconInactive, size: CGSize(width: 35, height: 35))
        homeVC.tabBarItem.title = ""
        homeVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6.0, left: 0, bottom: -6.0, right: 0);
        
        networkVC.tabBarItem = UITabBarItem()
        networkVC.tabBarItem.image = UIImage.fontAwesomeIcon(name: .users, style: .solid, textColor: mainColorScheme.tabBarIconInactive, size: CGSize(width: 35, height: 35))
        networkVC.tabBarItem.title = ""
        networkVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6.0, left: 0, bottom: -6.0, right: 0);

        
        reportsVC.tabBarItem = UITabBarItem()
        reportsVC.tabBarItem.image = UIImage.fontAwesomeIcon(name: .chartLine, style: .solid, textColor: mainColorScheme.tabBarIconInactive, size: CGSize(width: 35, height: 35))
        reportsVC.tabBarItem.title = ""
        reportsVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6.0, left: 0, bottom: -6.0, right: 0);
        
        guard let logIcon = UIImage(named: "log") else { return }
        logVC.tabBarItem = UITabBarItem()
        logVC.tabBarItem.image = logIcon.withRenderingMode(.alwaysOriginal)
        logVC.tabBarItem.selectedImage = logIcon.withRenderingMode(.alwaysOriginal)
        logVC.tabBarItem.title = ""
        logVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6.0, left: 0, bottom: -6.0, right: 0);
        
        let controllers = [homeVC, networkVC, reportsVC, logVC]
        
        UITabBar.appearance().tintColor = mainColorScheme.tabBarIconActive
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: mainColorScheme.tabBarIconInactive], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: mainColorScheme.tabBarIconActive], for: .selected)
        
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

}
