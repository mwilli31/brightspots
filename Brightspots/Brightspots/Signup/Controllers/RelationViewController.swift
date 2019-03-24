//
//  RelationViewController.swift
//  Brightspots
//
//  Created by Michael Williams on 3/11/19.
//  Copyright © 2019 Michael Williams. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_ButtonThemer
import MaterialComponents.MaterialButtons_ColorThemer

class RelationViewController: UIViewController {

    var label = UILabel()
    var labelConstraint = [NSLayoutConstraint]()
    
    let buttonScheme = MDCButtonScheme()
    
    var parentButton = MDCButton()
    var parentButtonConstraint = [NSLayoutConstraint]()
    let PARENT_TAG = 1
    
    var siblingButton = MDCButton()
    var siblingButtonConstraint = [NSLayoutConstraint]()
    let SIBLING_TAG = 2
    
    var spouseButton = MDCButton()
    var spouseButtonConstraint = [NSLayoutConstraint]()
    let SPOUSE_TAG = 3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = signUpColorScheme.backgroundColor
        setUpLabel()
        setUpButtons()
        setUpContraints()
    }
    
    private func setUpLabel() {
        label.text = "How are you related?"
        label.textColor = mainColorScheme.onBackgroundColor
        label.textAlignment = .center
        label.numberOfLines = 0 //allows for wrapping
        label.font = Constants.Font.INTRO_DESCRIPTION
        self.view.addSubview(label)
    }
    
    private func setUpButtons() {
        MDCContainedButtonThemer.applyScheme(buttonScheme, to: parentButton)
        parentButton.backgroundColor = signUpColorScheme.primaryColor
        parentButton.setTitle("Parent", for: .normal)
        parentButton.tag = PARENT_TAG
        parentButton.addTarget(self, action: #selector(ChooseAccountTypeViewController.buttonAction(_:)), for: .touchUpInside)
        self.view.addSubview(parentButton)
        
        MDCContainedButtonThemer.applyScheme(buttonScheme, to: siblingButton)
        siblingButton.setTitle("Sibling", for: .normal)
        siblingButton.backgroundColor = signUpColorScheme.primaryColorVariant
        siblingButton.tag = SIBLING_TAG
        siblingButton.addTarget(self, action: #selector(ChooseAccountTypeViewController.buttonAction(_:)), for: .touchUpInside)
        self.view.addSubview(siblingButton)
        
        MDCContainedButtonThemer.applyScheme(buttonScheme, to: spouseButton)
        spouseButton.setTitle("Spouse", for: .normal)
        spouseButton.backgroundColor = signUpColorScheme.secondaryColor
        spouseButton.tag = SPOUSE_TAG
        spouseButton.addTarget(self, action: #selector(DiabeticTypeViewController.buttonAction(_:)), for: .touchUpInside)
        self.view.addSubview(spouseButton)
    }
    
    @objc func buttonAction(_ sender:UIButton!)
    {
        print("Button tapped")
        print(sender.tag)
        switch sender.tag {
        case PARENT_TAG:
            let nextVC = DiabeticTypeViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        case SIBLING_TAG:
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
        
        self.parentButton.translatesAutoresizingMaskIntoConstraints = false
        self.parentButtonConstraint.removeAll()
        self.parentButton.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 40).isActive = true
        self.parentButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        self.parentButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        self.parentButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        self.view.addConstraints(parentButtonConstraint)
        
        self.siblingButton.translatesAutoresizingMaskIntoConstraints = false
        self.siblingButtonConstraint.removeAll()
        self.siblingButton.topAnchor.constraint(equalTo: self.parentButton.bottomAnchor, constant: 20).isActive = true
        self.siblingButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        self.siblingButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        self.siblingButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        self.view.addConstraints(siblingButtonConstraint)
        
        self.spouseButton.translatesAutoresizingMaskIntoConstraints = false
        self.spouseButtonConstraint.removeAll()
        self.spouseButton.topAnchor.constraint(equalTo: self.siblingButton.bottomAnchor, constant: 20).isActive = true
        self.spouseButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        self.spouseButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        self.spouseButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        self.view.addConstraints(spouseButtonConstraint)
        
    }

}
