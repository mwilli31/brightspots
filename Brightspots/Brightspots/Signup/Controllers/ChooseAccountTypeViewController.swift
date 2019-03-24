//
//  ChooseAccountTypeViewController.swift
//  Brightspots
//
//  Created by Michael Williams on 3/10/19.
//  Copyright © 2019 Michael Williams. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_ButtonThemer
import MaterialComponents.MaterialButtons_ColorThemer

class ChooseAccountTypeViewController: UIViewController {
    
    var label = UILabel()
    var labelConstraint = [NSLayoutConstraint]()
    
    let buttonScheme = MDCButtonScheme()

    var diabeticButton = MDCButton()
    var diabeticButtonConstraint = [NSLayoutConstraint]()
    let DIABETIC_BUTTON_TAG = 1

    var someoneIKnowButton = MDCButton()
    var someoneIKnowButtonConstraint = [NSLayoutConstraint]()
    let SOMEONE_I_KNOW_BUTTON_TAG = 2

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = signUpColorScheme.backgroundColor
        setUpLabel()
        setUpButtons()
        setUpContraints()
    }
    
    private func setUpLabel() {
        label.text = "Are you using Brightspots for yourself or to support someone you know?"
        label.textColor = signUpColorScheme.onBackgroundColor
        label.textAlignment = .center
        label.numberOfLines = 0 //allows for wrapping
        label.font = Constants.Font.INTRO_DESCRIPTION
        self.view.addSubview(label)
    }
    
    private func setUpButtons() {
        MDCContainedButtonThemer.applyScheme(buttonScheme, to: diabeticButton)
        diabeticButton.backgroundColor = signUpColorScheme.primaryColor
        diabeticButton.setTitle("I Am Diabetic", for: .normal)
        diabeticButton.tag = DIABETIC_BUTTON_TAG
        diabeticButton.addTarget(self, action: #selector(ChooseAccountTypeViewController.buttonAction(_:)), for: .touchUpInside)
        self.view.addSubview(diabeticButton)
        
        MDCContainedButtonThemer.applyScheme(buttonScheme, to: someoneIKnowButton)
        someoneIKnowButton.setTitle("Someone I Know Is Diabetic", for: .normal)
        someoneIKnowButton.backgroundColor = signUpColorScheme.primaryColorVariant
        someoneIKnowButton.tag = SOMEONE_I_KNOW_BUTTON_TAG
        someoneIKnowButton.addTarget(self, action: #selector(ChooseAccountTypeViewController.buttonAction(_:)), for: .touchUpInside)
        self.view.addSubview(someoneIKnowButton)
    }
    
    @objc func buttonAction(_ sender:UIButton!)
    {
        print("Button tapped")
        print(sender.tag)
        switch sender.tag {
        case DIABETIC_BUTTON_TAG:
            let nextVC = DiabeticTypeViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        case SOMEONE_I_KNOW_BUTTON_TAG:
            let nextVC = RelationViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        default:
            return
        }
    }
    
    private func setUpContraints() {
        // Get the superview's layout
        let margins = self.view.layoutMarginsGuide
        
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.labelConstraint.removeAll()
        self.label.topAnchor.constraint(equalTo: margins.topAnchor, constant: 40).isActive = true
        self.label.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 40).isActive = true
        self.label.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -40).isActive = true
        self.view.addConstraints(labelConstraint)
        
        self.diabeticButton.translatesAutoresizingMaskIntoConstraints = false
        self.diabeticButtonConstraint.removeAll()
        self.diabeticButton.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 40).isActive = true
        self.diabeticButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        self.diabeticButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        self.diabeticButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        self.view.addConstraints(diabeticButtonConstraint)
        
        self.someoneIKnowButton.translatesAutoresizingMaskIntoConstraints = false
        self.someoneIKnowButtonConstraint.removeAll()
        self.someoneIKnowButton.topAnchor.constraint(equalTo: self.diabeticButton.bottomAnchor, constant: 20).isActive = true
        self.someoneIKnowButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        self.someoneIKnowButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        self.someoneIKnowButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        self.view.addConstraints(someoneIKnowButtonConstraint)

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
