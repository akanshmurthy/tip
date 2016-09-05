//
//  ViewController.swift
//  tips
//
//  Created by Akansh Murthy on 2/28/16.
//  Copyright © 2016 Akansh Murthy. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var currencySignLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var divideByPeopleControl: UISegmentedControl!
    @IBOutlet weak var plusSignLabel: UILabel!
    var totalBill = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        hideOnStart(true)
        
        billField.text = ""
        tipLabel.text = "0.00"
        totalLabel.text = "0.00"
        
        billField.becomeFirstResponder()
        
    }
    
    func hideOnStart(hideOnStart: Bool) {
        let opacity: CGFloat = hideOnStart ? 0 : 1
        
        tipLabel.alpha = opacity
        totalLabel.alpha = opacity
        tipControl.alpha = opacity
        backgroundView.alpha = opacity
        currencySignLabel.alpha = opacity
        plusSignLabel.alpha = opacity
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func divideNumber() -> Double {
        let selectedPeopleIndex = divideByPeopleControl.selectedSegmentIndex
        return selectedPeopleIndex._bridgeToObjectiveC().doubleValue + 1.0
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        hideOnStart(false)
        let tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount = billField.text!._bridgeToObjectiveC().doubleValue
        let tip = billAmount * tipPercentage
        let total = (billAmount + tip) / divideNumber()
        totalBill = total
        
        tipLabel.text = "\(tip)"
        totalLabel.text = "\(total)"
        
        tipLabel.text = String(format: "%.2f", tip)
        totalLabel.text = String(format: "%.2f", total)
        currencySignLabel.rotate360Degrees()
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        let selectedTipIndex = defaults.integerForKey("selectedTipIndex")
        tipControl.selectedSegmentIndex = selectedTipIndex
        
        let currentCurrencyIndex = defaults.integerForKey("selectedCurrencyIndex")
        if (currentCurrencyIndex == 0) {
            currencySignLabel.text = "$"
        } else if (currentCurrencyIndex == 1) {
            currencySignLabel.text = "€"
        } else {
            currencySignLabel.text = "£"
        }
        
        let currentColorIndex = defaults.integerForKey("selectedColorIndex")
        if (currentColorIndex == 0) {
            backgroundView.backgroundColor = UIColor.clearColor()
            billField.textColor = UIColor.blackColor()
            tipLabel.textColor = UIColor.blackColor()
            totalLabel.textColor = UIColor.blackColor()
            currencySignLabel.textColor = UIColor.blackColor()
        } else if (currentColorIndex == 1) {
            backgroundView.backgroundColor = UIColor.blackColor()
            backgroundView.alpha = 0.5
            billField.textColor = UIColor.redColor()
            tipLabel.textColor = UIColor.redColor()
            totalLabel.textColor = UIColor.redColor()
            currencySignLabel.textColor = UIColor.redColor()

        }
        
        let tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount = billField.text!._bridgeToObjectiveC().doubleValue
        let tip = billAmount * tipPercentage
        let total = (billAmount + tip) / divideNumber()
        totalBill = total
        
        tipLabel.text = "\(tip)"
        totalLabel.text = "\(total)"
        
        tipLabel.text = String(format: "%.2f", tip)
        totalLabel.text = String(format: "%.2f", total)
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func sendMessage() {
        let messageVC = MFMessageComposeViewController()
        let testVar = String (format: "%.2f", totalBill)
        messageVC.body = "I owe you $" + "\(testVar)" + "."
        messageVC.recipients = []
        messageVC.messageComposeDelegate = self
        
        presentViewController(messageVC, animated: true, completion: nil)
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        switch result.rawValue {
        case MessageComposeResultCancelled.rawValue :
            print("message canceled")
            
        case MessageComposeResultFailed.rawValue :
            print("message failed")
            
        case MessageComposeResultSent.rawValue :
            print("message sent")
            
        default:
            break
        }
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func payAction(sender: AnyObject) {
        sendMessage()
    }

}

