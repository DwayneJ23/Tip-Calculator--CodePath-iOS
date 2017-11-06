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
    }
    
    @IBAction func clear(_ sender: Any) {
        billField.text = ""
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        numberOfPeopleField.text = "1"
        totalPerPersonLabel.text = "$0.00"
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

