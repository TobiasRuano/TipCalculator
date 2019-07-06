//
//  ExtensionUITextField.swift
//  TipCalculator
//
//  Created by Tobias Ruano on 08/04/2019.
//  Copyright © 2019 Tobias Ruano. All rights reserved.
//

import UIKit

@IBDesignable
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
    
    @objc func doneButtonAction(money: Double) -> Double {
        var price = 0.0
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
        
        return price
    }
}
