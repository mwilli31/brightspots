//
//  LaunchViewController.swift
//  Brightspots
//
//  Created by Michael Williams on 3/10/19.
//  Copyright © 2019 Michael Williams. All rights reserved.
//

import UIKit
import Auth0
import paper_onboarding

class LaunchViewController: UIViewController {

    @IBOutlet weak var getStartedButton: UIButton!
    
    var loggedIn: Bool!
    
    fileprivate let items = [
        OnboardingItemInfo(informationImage: UIImage(named:"logo")!,
                           title: "Discover more Brightspots",
                           description: "Let Brightspots help you understand how your habits effect blood sugars and daily wellbeing",
                           pageIcon: UIImage(named:"logo")!,
                           color: UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: Constants.Font.INTRO_TITLE, descriptionFont: Constants.Font.INTRO_DESCRIPTION),
        
        OnboardingItemInfo(informationImage: UIImage(named:"logo")!,
                           title: "Build stronger routines",
                           description: "Currated and proven journeys sourced from care teams and the community help you build new daily routines and incrementally improve diabetes management",
                           pageIcon: UIImage(named:"logo")!,
                           color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: Constants.Font.INTRO_TITLE, descriptionFont: Constants.Font.INTRO_DESCRIPTION),
        
        OnboardingItemInfo(informationImage: UIImage(named:"logo")!,
                           title: "Share, Socialize, Support",
                           description: "We are all here for one another. Work together, empathize together, improve together. #WEARENOTWAITING",
                           pageIcon: UIImage(named:"logo")!,
                           color: UIColor(red: 0.61, green: 0.56, blue: 0.74, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: Constants.Font.INTRO_TITLE, descriptionFont: Constants.Font.INTRO_DESCRIPTION),
        
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStartedButton.isHidden = true

        setupPaperOnboardingView()
        
        view.bringSubviewToFront(getStartedButton)
        
        self.loggedIn = false
    }
    
    @IBAction func getStartedAction(_ sender: Any) {
        
        //if not logged in present the log in screen
        if(!self.loggedIn) {
            Auth0
                .webAuth()
                .scope("openid profile")
                .audience("https://brightspots.auth0.com/userinfo")
                .start {
                    switch $0 {
                    case .failure(let error):
                        // Handle the error
                        print("Error: \(error)")
                    case .success(let credentials):
                        // Do something with credentials e.g.: save them.
                        // Auth0 will automatically dismiss the login page
                        self.loggedIn = true
                        print("Credentials: \(credentials)")
                        print("Token: \(credentials.accessToken)")
                        //send it back to the main thread
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "mainSegue", sender: self)
                        }
                    }
            }
        }
    }
    
    private func transitionToMain() {
        self.performSegue(withIdentifier: "mainSegue", sender: self)
    }
    
    private func setupPaperOnboardingView() {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        // Add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("here")
    }
 
}

// MARK: PaperOnboardingDelegate
extension LaunchViewController: PaperOnboardingDelegate {
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        getStartedButton.isHidden = index == 2 ? false : true
    }
    
    func onboardingDidTransitonToIndex(_: Int) {
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        //item.titleLabel?.backgroundColor = .redColor()
        //item.descriptionLabel?.backgroundColor = .redColor()
        //item.imageView = ...
    }
}

// MARK: PaperOnboardingDataSource
extension LaunchViewController: PaperOnboardingDataSource {
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }
    
    func onboardingConfigurationItem(item: OnboardingContentViewItem, index: Int) {
        print("here")
        //    item.titleLabel?.backgroundColor = .redColor()
        //    item.descriptionLabel?.backgroundColor = .redColor()
        //    item.imageView = ...
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    //    func onboardinPageItemRadius() -> CGFloat {
    //        return 2
    //    }
    //
    //    func onboardingPageItemSelectedRadius() -> CGFloat {
    //        return 10
    //    }
    //    func onboardingPageItemColor(at index: Int) -> UIColor {
    //        return [UIColor.white, UIColor.red, UIColor.green][index]
    //    }
}
