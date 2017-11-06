//
//  SettingsViewController.swift
//  TIPR
//
//  Created by Dwayne Johnson on 11/6/17.
//  Copyright © 2017 Dwayne Johnson. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    @IBOutlet weak var defaultTitleLabel: UILabel!
    @IBOutlet weak var defaultButton: UIButton!
    @IBOutlet weak var currentDefaultLabel: UILabel!
    @IBOutlet weak var currentTitleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Load default tip value
        let defaults = UserDefaults.standard
        let tipValue = defaults.integer(forKey: "default_tip_percentage")
        defaultTipControl.selectedSegmentIndex = tipValue
        
        // Update current default tip label
        currentDefaultLabel.text = defaultTipControl.titleForSegment(at: tipValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        defaultTitleLabel.alpha = 0.0
        defaultTipControl.alpha = 0.0
        defaultButton.alpha = 0.0
        currentTitleLabel.alpha = 0.0
        currentDefaultLabel.alpha = 0.0
        
        UIView.animate(withDuration: 2.0,
            animations: {
            self.defaultTitleLabel.alpha = 1.0
            self.defaultTipControl.alpha = 1.0
            self.defaultButton.alpha = 1.0
            self.currentTitleLabel.alpha = 1.0
            self.currentDefaultLabel.alpha = 1.0
        })
    }
    
    @IBAction func setDefaultTip(_ sender: Any) {
        let index = defaultTipControl.selectedSegmentIndex
        
        // Save default tip
        let defaults = UserDefaults.standard
        defaults.set(index, forKey: "default_tip_percentage")
        defaults.synchronize()
        
        // Alert message - tip saved conformation
        let alert = UIAlertController(title: "Saved", message: "Default tip has been saved", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        // Update current default tip label
        currentDefaultLabel.text = defaultTipControl.titleForSegment(at: index)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
