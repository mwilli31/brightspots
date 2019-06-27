//
//  IntroViewController.swift
//  Brightspots
//
//  Created by Michael Williams on 3/23/19.
//  Copyright © 2019 Michael Williams. All rights reserved.
//


import UIKit
import Auth0
import paper_onboarding

class IntroViewController: UIViewController {
    
    var getStartedButton: UIButton!
    var getStartedButtonConstraint = [NSLayoutConstraint]()
    
    fileprivate let items = [
        OnboardingItemInfo(informationImage: UIImage(named:"logo")!,
                           title: "Discover more Brightspots",
                           description: "Let Brightspots help you understand how your habits effect blood sugars and daily wellbeing",
                           pageIcon: UIImage(named:"logo")!,
                           color: UIColor.init(hex: Colors.LIGHT_BLUE),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: Constants.Font.INTRO_TITLE, descriptionFont: Constants.Font.INTRO_DESCRIPTION),
        
        OnboardingItemInfo(informationImage: UIImage(named:"logo")!,
                           title: "Build stronger routines",
                           description: "Currated and proven journeys sourced from care teams and the community help you build new daily routines and incrementally improve diabetes management",
                           pageIcon: UIImage(named:"logo")!,
                           color: UIColor.init(hex: Colors.LIGHT_GREEN),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: Constants.Font.INTRO_TITLE, descriptionFont: Constants.Font.INTRO_DESCRIPTION),
        
        OnboardingItemInfo(informationImage: UIImage(named:"logo")!,
                           title: "Share, Socialize, Support",
                           description: "We are all here for one another. Work together, empathize together, improve together. #WEARENOTWAITING",
                           pageIcon: UIImage(named:"logo")!,
                           color: UIColor.init(hex: Colors.BRIGHT_ORANGE),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: Constants.Font.INTRO_TITLE, descriptionFont: Constants.Font.INTRO_DESCRIPTION),
        
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPaperOnboardingView()
        setupGetStartedButton()
    }
    
    // MARK: - Setup (move to a view for cleanliness)
    
    private func setupGetStartedButton() {
        self.getStartedButton = UIButton()
        self.getStartedButton.backgroundColor = .clear
        self.getStartedButton.setTitleColor(.white, for: .normal)
        self.getStartedButton.setTitle("Get Started", for: .normal)
        self.getStartedButton.addTarget(self, action: #selector(IntroViewController.getStartedAction(_:)), for: .touchUpInside)
        self.getStartedButton.isHidden = true
        self.view.addSubview(getStartedButton)
        setUpButtonContraints()
        self.view.bringSubviewToFront(getStartedButton)
    }
    
    private func setUpButtonContraints() {
        // Get the superview's layout
        let margins = self.view.layoutMarginsGuide
        
        self.getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        self.getStartedButtonConstraint.removeAll()
        self.getStartedButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 40).isActive = true
        self.getStartedButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        self.view.addConstraints(getStartedButtonConstraint)
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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Navigation
    
    @objc func getStartedAction(_ sender:UIButton!) {
        let nextVC = ChooseAccountTypeViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("here")
    }
    
}

// MARK: PaperOnboardingDelegate
extension IntroViewController: PaperOnboardingDelegate {
    
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
extension IntroViewController: PaperOnboardingDataSource {
    
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
    
    func onboardinPageItemRadius() -> CGFloat {
        return 2
    }
    
    func onboardingPageItemSelectedRadius() -> CGFloat {
        return 10
    }
}

