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
    @IBOutlet weak var backgroundView: UIView!
    
    @IBAction func tipChanged(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        let selectedTipIndex = defaultTipControl.selectedSegmentIndex
        defaults.set(selectedTipIndex, forKey: "selectedTipIndex")
        defaults.synchronize()
    }
    
    @IBAction func currencyChanged(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        let selectedCurrencyIndex = currencyChangeControl.selectedSegmentIndex
        defaults.set(selectedCurrencyIndex, forKey: "selectedCurrencyIndex")
        defaults.synchronize()
    }
    
    @IBAction func colorChanged(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        let selectedColorIndex = colorChangeControl.selectedSegmentIndex
        defaults.set(selectedColorIndex, forKey: "selectedColorIndex")
        defaults.synchronize()
        if (selectedColorIndex == 0) {
            backgroundView.backgroundColor = UIColor.red
            backgroundView.alpha = 0.3
        } else if (selectedColorIndex == 1) {
            backgroundView.backgroundColor = UIColor.gray
            backgroundView.alpha = 0.5
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        let currentTipIndex = defaults.integer(forKey: "selectedTipIndex")
        let currentCurrencyIndex = defaults.integer(forKey: "selectedCurrencyIndex")
        let currentColorIndex = defaults.integer(forKey: "selectedColorIndex")
        defaultTipControl.selectedSegmentIndex = currentTipIndex
        currencyChangeControl.selectedSegmentIndex = currentCurrencyIndex
        colorChangeControl.selectedSegmentIndex = currentColorIndex
    }

    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let currentColorIndex = defaults.integer(forKey: "selectedColorIndex")
        if (currentColorIndex == 0) {
            backgroundView.backgroundColor = UIColor.red
            backgroundView.alpha = 0.3
        } else if (currentColorIndex == 1) {
            backgroundView.backgroundColor = UIColor.gray
            backgroundView.alpha = 0.5
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissAction(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
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
