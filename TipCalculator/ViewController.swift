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

    @IBAction func doneEditingTextField(_ sender: UITextField) {
        doneButtonAction()
        let porcentaje = price * 0.15
        tipPriceLabel.text = NSString(format: "$%.2f", (porcentaje)) as String
        
        initialPriceTextField.text = NSString(format: "$%.2f", (price)) as String
        
        totalPrice = porcentaje + price
        totalPriceLabel.text = NSString(format: "$%.2f", totalPrice) as String
        
        let totalPerPerson = (totalPrice / SplitStepper.value)
        totalPerPersonLabel.text = NSString(format: "$%.2f", totalPerPerson) as String
        
        slider.setValue(0.15, animated: true)
    }
    @IBAction func SliderAction(_ sender: Any) {
        initialPriceTextField.resignFirstResponder()
        let value: Int = Int((slider.value)*100)
        percentageTipLabel.text = "Tip (\(value)%)"
        
        initialPriceTextField.text = NSString(format: "$%.2f", (price)) as String
        let percentage = Double(price * Double(value))/100
        
        totalPrice = percentage + price
        
        tipPriceLabel.text = NSString(format: "$%.2f", (percentage)) as String
        totalPriceLabel.text = NSString(format: "$%.2f", totalPrice) as String
        let perPersonPrice = (totalPrice / SplitStepper.value)
        totalPerPersonLabel.text = NSString(format: "$%.2f", perPersonPrice) as String
    }
    
    @IBAction func splitBetween(_ sender: UIStepper) {
        splitPersonsLabel.text = "\(Int(sender.value))"
        let result = totalPrice / sender.value
        totalPerPersonLabel.text = NSString(format: "$%.2f", (result)) as String
    }
    
    //TODO: Not okey here
    func doneButtonAction() {
        self.resignFirstResponder()

        if initialPriceTextField.text == "" {
            initialPriceTextField.text? = "$"
        }
        if initialPriceTextField.text?.description.prefix(1) == "$" {
            initialPriceTextField.text = initialPriceTextField.text?.components(separatedBy: ["$"]).joined()
        }
        if let prueba = Double(initialPriceTextField.text!){
            price = prueba
            initialPriceTextField.text = "$\(initialPriceTextField.text!)"
        }
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
        if self.text?.description.prefix(1) == "$" {
            self.text? = (self.text?.components(separatedBy: ["$"]).joined())!
        }
        if let prueba = Double(self.text!){
            price = prueba
            self.text = "$\(self.text!)"
        }
    }
}
