//
//  ViewController.swift
//  TipCalculator
//
//  Created by Tobias Ruano on 14/7/18.
//  Copyright © 2018 Tobias Ruano. All rights reserved.
//

import UIKit

var price: Double = 0

class ViewController: UIViewController {

    @IBOutlet weak var initialPriceTextField: UITextField!
    @IBOutlet weak var tipPriceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var percentageTipLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var splitPersonsLabel: UILabel!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var SplitStepper: UIStepper!
    
    var totalPrice = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.setValue(0.15, animated: false)
        setUI()
    }
    
    func setUI() {
        SplitStepper.minimumValue = 1
        SplitStepper.stepValue = 1
        splitPersonsLabel.text = "1"
        totalPerPersonLabel.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func SliderAction(_ sender: Any) {
        initialPriceTextField.resignFirstResponder()
        let value: Int = Int((slider.value)*100)
        percentageTipLabel.text = "Tip (\(value)%)"
        
        initialPriceTextField.text = "$\(price)"
        let percentage = Double(price * Double(value))/100
        
        totalPrice = percentage + price
        
        tipPriceLabel.text = NSString(format: "$%.2f", (percentage)) as String
        totalPriceLabel.text = NSString(format: "$%.2f", totalPrice) as String
    }
    
    @IBAction func splitBetween(_ sender: UIStepper) {
        splitPersonsLabel.text = "\(Int(sender.value))"
        let result = totalPrice / sender.value
        totalPerPersonLabel.text = NSString(format: "$%.2f", (result)) as String
    }
    
}

extension UITextField {
    
    @IBInspectable var doneAccessory: Bool {
        get {
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
        
        if self.text == "" {
            self.text? = "$"
        }
        if self.text?.description[0] == "$" {
            self.text = self.text?.components(separatedBy: ["$"]).joined()
        }
        if let prueba = Double(self.text!){
            price = prueba
            self.text = "$\(self.text!)"
        }
    }
}

//Extension to be able to use self.text?.description[0] == "$"
extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}
extension Substring {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}
