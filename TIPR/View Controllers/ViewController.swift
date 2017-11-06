//
//  ViewController.swift
//  TIPR
//
//  Created by Dwayne Johnson on 11/5/17.
//  Copyright © 2017 Dwayne Johnson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var numberOfPeopleField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!   // Global variable to update tip UIlabel dynamically
    @IBOutlet weak var totalLabel: UILabel!   // Global variable to update total UIlabel dynamically
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!  // Controls tip value

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        billField.text = ""
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        numberOfPeopleField.text = "1"
        totalPerPersonLabel.text = "$0.00"
        
        // Load default tip percentage from SettingsViewController
        // with associated key "default_tip_percentage"
        
        let defaults = UserDefaults.standard
        let tipValue = defaults.integer(forKey: "default_tip_percentage")
        tipControl.selectedSegmentIndex = tipValue
        
        // Load data from previous session if the time from last use
        // is less than 10 mins, otherwise start fresh
        
        // If previous time is nil set previous to current time
        // this means it is the users first time using the app, or
        // all settings were refreshed
        
        if let previousTime: NSDate = defaults.object(forKey: "previousTime") as? NSDate {
            let elapasedTime = NSDate().timeIntervalSince(previousTime as Date)
            if (elapasedTime < 600)
            {
                // Load saved bill, tip, and number of people fields
                
                let savedBill = defaults.string(forKey: "savedBillField")
                billField.text = savedBill
                
                let savedTipValue = defaults.integer(forKey: "savedTip")
                tipControl.selectedSegmentIndex = savedTipValue
                
                let savedPeople = defaults.string(forKey: "savedNumberOfPeopleField")
                numberOfPeopleField.text = savedPeople
            }
        }
        
        // Save current time
        let currentTime: NSDate! = NSDate()
        defaults.set(currentTime, forKey: "previousTime")
        defaults.synchronize()
        
        // The bill amount is always the first responder. This way
        // the user doesn't have to tap anywhere to use this app.
        // Just launch the app and start typing.
        
        billField.becomeFirstResponder()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // print("view will appear")
        
        // This is a good place to retrieve the default tip percentage from NSUserDefaults
        // and use it to update the tip amount
        
        // Load default tip percentage from SettingsViewController
        // with associated key "default_tip_percentage"
        
        let defaults = UserDefaults.standard
        let tipValue = defaults.integer(forKey: "default_tip_percentage")
        tipControl.selectedSegmentIndex = tipValue
        
        // Create function to update totals after default tip has been changed
        updateFields()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        updateFields()
        
        // Save bill, tip, and number of people fields
        let index = tipControl.selectedSegmentIndex
        let defaults = UserDefaults.standard
        defaults.set(billField.text, forKey: "savedBillField")
        defaults.set(index, forKey: "savedTip")
        defaults.set(numberOfPeopleField.text, forKey: "savedNumberOfPeopleField")
        defaults.synchronize()
        
    }
    
    @IBAction func clear(_ sender: Any) {
        billField.text = ""
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        numberOfPeopleField.text = "1"
        totalPerPersonLabel.text = "$0.00"
        
        // Save bill, tip, and number of people fields
        let index = tipControl.selectedSegmentIndex
        let defaults = UserDefaults.standard
        defaults.set(billField.text, forKey: "savedBillField")
        defaults.set(index, forKey: "savedTip")
        defaults.set(numberOfPeopleField.text, forKey: "savedNumberOfPeopleField")
        defaults.synchronize()
    }
    
    func updateFields(){
        
        let tipPercentages = [0.05, 0.10, 0.15, 0.20]
        let bill = NSString(string: billField.text!).doubleValue // String to double conversion
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex] // Calculate tip amount
        let total = bill + tip // Calculate bill total with tip included
        let people = NSString(string: numberOfPeopleField.text!).doubleValue // String to double conversion
        let costPerPerson = total / Double(people)  // Calcualate cost per person
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        if(Double(people) == 0 ){
            totalPerPersonLabel.text = "$0.00"
        }
        else {
            totalPerPersonLabel.text = String(format: "$%.2f", costPerPerson)
        }
        
    }
}

