//
//  SettingViewController.swift
//  tiperoo
//
//  Created by Brandon Aubrey on 3/6/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//

import Foundation
import UIKit


class SettingsViewController: UIViewController, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate{
    
    @IBOutlet weak var buttonOne:   UIButton!
    @IBOutlet weak var buttonTwo:   UIButton!
    @IBOutlet weak var slider:      UISlider!
    @IBOutlet weak var splitStepper: UIStepper!
    
    var colorOne = UIColor(red: 223, green: 255, blue: 1, alpha: 242){
        didSet{ buttonOne.setTitleColor(colorOne, for:UIControlState()) }
    }
    var colorTwo = UIColor(red: 254, green: 176, blue: 57, alpha: 1){
        didSet{ buttonTwo.setTitleColor(colorTwo, for:UIControlState()) }
    }
    var split = 1{
        didSet{
            splitLabel.text = "Number of people splitting: \(split)"
        }
    }
    let formatter = NumberFormatter()
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var customValueLabel:    UILabel!
    @IBOutlet weak var splitLabel:          UILabel!
    
    var customValue: Int = 0 {
        didSet {
            customValueLabel.text = "Custom Percentage: \(formatter.string(from: customValue as NSNumber)!)%"
        }
    }
    
    @IBAction func customValueSlider(_ sender: UISlider) {
        customValue = Int(sender.value * 100)
    }
    
    @IBAction func splitStepper(_ sender: UIStepper) {
        split = Int(sender.value)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.minimum = 2
        formatter.maximum = 3
        navigationController?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        defaults.set(customValue, forKey: "customPerct")
        defaults.setColor(color: colorOne, forKey: "colorOne")
        defaults.setColor(color: colorTwo, forKey: "colorTwo")
        defaults.set(split, forKey: "split")
        defaults.synchronize()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let c1 = defaults.colorForKey(key: "colorOne"), let c2 = defaults.colorForKey(key: "colorTwo") {
            colorOne = c1
            colorTwo = c2
        }
        customValue = defaults.integer(forKey: "customPerct")
        split = defaults.integer(forKey: "split")
        splitStepper.value = Double(split)
        slider.value = Float(customValue) / 100
    }

    @IBAction func colorPickerButton(_ sender: UIButton) {
        
        let popoverVC = storyboard?.instantiateViewController(withIdentifier: "colorPickerPopover") as! ColorPickerViewController
        popoverVC.modalPresentationStyle = .popover
        popoverVC.preferredContentSize = CGSize(width: 284, height: 446)
        if let popoverController = popoverVC.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = CGRect(x: 0, y: 0, width: 85, height: 30)
            popoverController.permittedArrowDirections = .any
            popoverController.delegate = self
            popoverVC.button = sender
            popoverVC.delegate = self
        }
        present(popoverVC, animated: true, completion: nil)
    }
    
    func setButtonColor (_ color: UIColor, buttonColor: UIButton) {
        if buttonColor.tag == 1 {
            colorOne = color
        }else {
            colorTwo = color
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension UserDefaults {
    
    func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = data(forKey: key) {
            color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor
        }
        return color
    }
    
    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData?
        }
        set(colorData, forKey: key)
    }
    
}
