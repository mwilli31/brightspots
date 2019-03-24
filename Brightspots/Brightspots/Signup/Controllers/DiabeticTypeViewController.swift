//
//  DiabeticTypeViewController.swift
//  Brightspots
//
//  Created by Michael Williams on 3/11/19.
//  Copyright © 2019 Michael Williams. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_ButtonThemer
import MaterialComponents.MaterialButtons_ColorThemer

class DiabeticTypeViewController: UIViewController {
    
    var label = UILabel()
    var labelConstraint = [NSLayoutConstraint]()
    
    let buttonScheme = MDCButtonScheme()
    
    var type1Button = MDCButton()
    var type1ButtonConstraint = [NSLayoutConstraint]()
    let TYPE_1_TAG = 1
    
    var type2Button = MDCButton()
    var type2ButtonConstraint = [NSLayoutConstraint]()
    let TYPE_2_TAG = 2
    
    var preButton = MDCButton()
    var preButtonConstraint = [NSLayoutConstraint]()
    let PRE_TAG = 3
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = signUpColorScheme.backgroundColor
        setUpLabel()
        setUpButtons()
        setUpContraints()
    }
    
    private func setUpLabel() {
        label.text = "What type of diabetes do you have?"
        label.textColor = signUpColorScheme.onBackgroundColor
        label.textAlignment = .center
        label.numberOfLines = 0 //allows for wrapping
        label.font = Constants.Font.INTRO_DESCRIPTION
        self.view.addSubview(label)
    }
    
    private func setUpButtons() {
        MDCContainedButtonThemer.applyScheme(buttonScheme, to: type1Button)
        type1Button.backgroundColor = signUpColorScheme.primaryColor
        type1Button.setTitle("Type 1", for: .normal)
        type1Button.tag = TYPE_1_TAG
        type1Button.addTarget(self, action: #selector(ChooseAccountTypeViewController.buttonAction(_:)), for: .touchUpInside)
        self.view.addSubview(type1Button)
        
        MDCContainedButtonThemer.applyScheme(buttonScheme, to: type2Button)
        type2Button.setTitle("Type 2", for: .normal)
        type2Button.backgroundColor = signUpColorScheme.primaryColorVariant
        type2Button.tag = TYPE_2_TAG
        type2Button.addTarget(self, action: #selector(ChooseAccountTypeViewController.buttonAction(_:)), for: .touchUpInside)
        self.view.addSubview(type2Button)
        
        MDCContainedButtonThemer.applyScheme(buttonScheme, to: preButton)
        preButton.setTitle("Pre-diabetic", for: .normal)
        preButton.backgroundColor = signUpColorScheme.secondaryColor
        preButton.tag = PRE_TAG
        preButton.addTarget(self, action: #selector(DiabeticTypeViewController.buttonAction(_:)), for: .touchUpInside)
        self.view.addSubview(preButton)
    }
    
    @objc func buttonAction(_ sender:UIButton!)
    {
        print("Button tapped")
        print(sender.tag)
        switch sender.tag {
        case TYPE_1_TAG:
            let nextVC = DiabeticTypeViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        case TYPE_2_TAG:
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
        
        self.type1Button.translatesAutoresizingMaskIntoConstraints = false
        self.type1ButtonConstraint.removeAll()
        self.type1Button.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 40).isActive = true
        self.type1Button.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        self.type1Button.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        self.type1Button.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        self.view.addConstraints(type1ButtonConstraint)
        
        self.type2Button.translatesAutoresizingMaskIntoConstraints = false
        self.type2ButtonConstraint.removeAll()
        self.type2Button.topAnchor.constraint(equalTo: self.type1Button.bottomAnchor, constant: 20).isActive = true
        self.type2Button.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        self.type2Button.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        self.type2Button.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        self.view.addConstraints(type2ButtonConstraint)
        
        self.preButton.translatesAutoresizingMaskIntoConstraints = false
        self.preButtonConstraint.removeAll()
        self.preButton.topAnchor.constraint(equalTo: self.type2Button.bottomAnchor, constant: 20).isActive = true
        self.preButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        self.preButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
        self.preButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        self.view.addConstraints(preButtonConstraint)
        
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
