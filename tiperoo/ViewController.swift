//
//  ViewController.swift
//  tiperoo
//
//  Created by Brandon Aubrey on 3/2/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Variables
    @IBOutlet weak var tipSegmentController:    UISegmentedControl!
    @IBOutlet weak var billTextBox:             UITextField!
    @IBOutlet weak var tipLabel:                UILabel!
    @IBOutlet weak var totalLabel:              UILabel!
    @IBOutlet var background:                   BackgroundView!
    
    var customPerct: Int = 0{
        didSet{
            tipsArray[3] = Double(customPerct) / 100
            tipSegmentController.setTitle("\(customPerct)%", forSegmentAt: 3)
        }
    }
    
    let defaults =  UserDefaults.standard
    var tipsArray = [0.15,0.18,0.20,0.00]
    var tipPerct =  0.15
    var colorOne =  UIColor.red
    var colorTwo =  UIColor.blue
    var split =     1
    
    var tip = 0.00 {
        didSet {
            tipLabel.text = String(tip.roundTwo())
        }
    }
    var total = 0.00 {
        didSet {
            totalLabel.text = String(total.roundTwo())
        }
    }
    
    //MARK: -Actions
    @IBAction func tipPerctSelected(_ sender: UISegmentedControl) {
        tipPerct = tipsArray[sender.selectedSegmentIndex]
        if let bill = billTextBox.text, let value = Double(bill) {
            tip = Double(value) * tipPerct
            total = Double(value) + tip
        }
    }
    
    @IBAction func billFieldChanged(_ textField: UITextField) {
        
        if let text = textField.text, let value = Double(text) {
            tip = value * tipPerct
            total = tip + value
        } else{
            tip = 0
            total = 0
        }
    }
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let c1 = defaults.colorForKey(key: "colorOne"), let c2 = defaults.colorForKey(key: "colorTwo") {
            //set colors
            
            background.lightColor = c1
            background.darkColor = c2
        }
        customPerct = defaults.integer(forKey: "customPerct")
        split = defaults.integer(forKey: "split")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTwo() -> Double {
        let divisor = pow(10.0, Double(2))
        return (self * divisor).rounded() / divisor
    }
}

