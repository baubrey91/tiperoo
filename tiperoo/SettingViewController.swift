//
//  SettingViewController.swift
//  tiperoo
//
//  Created by Brandon Aubrey on 3/6/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//

import Foundation
import UIKit

protocol settingsDelegate {
    func setCustomTipPerc(customValue: Double)
    
}

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var customValueLabel: UILabel!
    var customValue = 0.00 {
        didSet {
            customValueLabel.text = "Custom Percentage: \(customValue)"
        }
    }
    
    @IBAction func customValueSlider(_ sender: UISlider) {
        customValue = Double(sender.value)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
