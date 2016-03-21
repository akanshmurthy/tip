//
//  SettingsViewController.swift
//  tips
//
//  Created by Akansh Murthy on 2/28/16.
//  Copyright © 2016 Akansh Murthy. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    @IBOutlet weak var currencyChangeControl: UISegmentedControl!
    @IBOutlet weak var colorChangeControl: UISegmentedControl!
    
    @IBAction func tipChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let selectedTipIndex = defaultTipControl.selectedSegmentIndex
        defaults.setInteger(selectedTipIndex, forKey: "selectedTipIndex")
        defaults.synchronize()
    }
    
    @IBAction func currencyChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let selectedCurrencyIndex = currencyChangeControl.selectedSegmentIndex
        defaults.setInteger(selectedCurrencyIndex, forKey: "selectedCurrencyIndex")
        defaults.synchronize()
    }
    
    @IBAction func colorChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let selectedColorIndex = colorChangeControl.selectedSegmentIndex
        defaults.setInteger(selectedColorIndex, forKey: "selectedColorIndex")
        defaults.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let defaults = NSUserDefaults.standardUserDefaults()
        let currentTipIndex = defaults.integerForKey("selectedTipIndex")
        let currentCurrencyIndex = defaults.integerForKey("selectedCurrencyIndex")
        let currentColorIndex = defaults.integerForKey("selectedColorIndex")
        defaultTipControl.selectedSegmentIndex = currentTipIndex
        currencyChangeControl.selectedSegmentIndex = currentCurrencyIndex
        colorChangeControl.selectedSegmentIndex = currentColorIndex
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
