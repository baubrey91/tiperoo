//
//  SettingViewController.swift
//  tiperoo
//
//  Created by Brandon Aubrey on 3/6/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//

import Foundation
import UIKit


class SettingsViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var customValueLabel: UILabel!
    var customValue = 0.00 {
        didSet {
            customValueLabel.text = "Custom Percentage: \(customValue.roundTwo())"
        }
    }
    
    @IBAction func customValueSlider(_ sender: UISlider) {
        customValue = Double(sender.value)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false

    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let controller = viewController as? ViewController {
            controller.customPerct = customValue.roundTwo()
        }
    }
}
