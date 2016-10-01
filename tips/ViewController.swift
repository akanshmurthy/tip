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
    @IBOutlet weak var payButton: UIButton!
    
    var totalBill = 0.00
    let initialTipLabelY: CGFloat = 200
    let plusSignLabelY: CGFloat = 200
    let currencySignLabelY: CGFloat = 260
    let totalLabelY: CGFloat = 260
    let tipControlY: CGFloat = 330
    let deltaY: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        hideOnStart(true)
        
        billField.text = ""
        tipLabel.text = "0.00"
        totalLabel.text = "0.00"
        
        billField.becomeFirstResponder()
        navigationController?.navigationBar.barTintColor = UIColor(red: 200/255.0, green: 50/255.0, blue: 50/255.0, alpha: 1.0)
    }
    
    func hideOnStart(_ hideOnStart: Bool) {
        let opacity: CGFloat = hideOnStart ? 0 : 1
        
        tipLabel.alpha = opacity
        totalLabel.alpha = opacity
        tipControl.alpha = opacity
        divideByPeopleControl.alpha = opacity
        payButton.alpha = opacity
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
    
    @IBAction func onEditingChanged(_ sender: AnyObject) {
        hideOnStart(false)
        animateFields()
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

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        let selectedTipIndex = defaults.integer(forKey: "selectedTipIndex")
        tipControl.selectedSegmentIndex = selectedTipIndex
        
        let currentCurrencyIndex = defaults.integer(forKey: "selectedCurrencyIndex")
        if (currentCurrencyIndex == 0) {
            currencySignLabel.text = "$"
        } else if (currentCurrencyIndex == 1) {
            currencySignLabel.text = "€"
        } else {
            currencySignLabel.text = "£"
        }
        
        let currentColorIndex = defaults.integer(forKey: "selectedColorIndex")
        if (currentColorIndex == 0) {
            backgroundView.backgroundColor = UIColor.red
            backgroundView.alpha = 0.3
            billField.textColor = UIColor.black
            tipLabel.textColor = UIColor.black
            totalLabel.textColor = UIColor.black
            currencySignLabel.textColor = UIColor.black
        } else if (currentColorIndex == 1) {
            backgroundView.backgroundColor = UIColor.gray
            backgroundView.alpha = 0.5
            billField.textColor = UIColor.red
            tipLabel.textColor = UIColor.red
            totalLabel.textColor = UIColor.red
            currencySignLabel.textColor = UIColor.red

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
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (billField.text!.isEmpty) {
            setYPosition(deltaY: deltaY)
        } else {
            setYPosition(deltaY: 0)
        }
    }
    
    func animateFields() {
        let duration = 0.5
        let delay = 0.5
        let options = UIViewAnimationOptions.transitionCurlUp
        
        if billField.text!.isEmpty {
            UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
                self.hideOnStart(true)
                self.setYPosition(deltaY: self.deltaY)
            }, completion: nil )
            
        } else {            
            UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
                self.hideOnStart(false)
                self.setYPosition(deltaY: 0)
            }, completion: nil )
        }
    }
    
    func setYPosition(deltaY: CGFloat) {
        tipLabel.center.y = initialTipLabelY - 10
        plusSignLabel.center.y = plusSignLabelY - 10
        currencySignLabel.center.y = currencySignLabelY - 20
        totalLabel.center.y = totalLabelY - 20
        tipControl.center.y = tipControlY - 40
    }
    
    func sendMessage() {
        let messageVC = MFMessageComposeViewController()
        let testVar = String (format: "%.2f", totalBill)
        messageVC.body = "I owe you $" + "\(testVar)" + "."
        messageVC.recipients = []
        messageVC.messageComposeDelegate = self
        
        present(messageVC, animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result.rawValue {
        case MessageComposeResult.cancelled.rawValue :
            print("message canceled")
            
        case MessageComposeResult.failed.rawValue :
            print("message failed")
            
        case MessageComposeResult.sent.rawValue :
            print("message sent")
            
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func payAction(_ sender: AnyObject) {
        sendMessage()
    }

}

