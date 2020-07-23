//
//  ViewController.swift
//  TipCalculator
//
//  Created by Tobias Ruano on 14/7/18.
//  Copyright © 2018 Tobias Ruano. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var initialPriceTextField: UITextField!
    @IBOutlet weak var tipPriceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var percentageTipLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var splitPersonsLabel: UILabel!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var splitStepper: UIStepper!
    
    var totalPrice = 0.0
    var price: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialPriceTextField.delegate = self
        
        slider.setValue(0.15, animated: false)
        //navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(named: "titleColor")]
        setUI()
        checkDeviceSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //view.backgroundColor = UIColor(named: "BackgroundGeneral")
        //self.navigationController?.navigationBar.backgroundColor = UIColor(named: "navColor")
    }
    
    func checkDeviceSize() {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.bounds.size.height{
            case 480:
                self.navigationController?.navigationBar.prefersLargeTitles = false
            case 568:
                self.navigationController?.navigationBar.prefersLargeTitles = false
            default:
                self.navigationController?.navigationBar.prefersLargeTitles = true
            }
        }
    }
    
    func setUI() {
        splitStepper.minimumValue = 1
        splitStepper.stepValue    = 1
        splitPersonsLabel.text    = "1"
        totalPerPersonLabel.text  = "$0.00"
    }

    @IBAction func doneEditingTextField(_ sender: UITextField) {
        price = initialPriceTextField.doneButtonAction(money: price)
        let porcentaje = price * 0.15
        tipPriceLabel.text = NSString(format: "$%.2f", (porcentaje)) as String
        initialPriceTextField.text = NSString(format: "$%.2f", (price)) as String
        totalPrice = porcentaje + price
        totalPriceLabel.text = NSString(format: "$%.2f", totalPrice) as String
        let totalPerPerson = (totalPrice / splitStepper.value)
        totalPerPersonLabel.text = NSString(format: "$%.2f", totalPerPerson) as String
        slider.setValue(0.15, animated: true)
        percentageTipLabel.text = "(15%)"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        doneEditingTextField(textField)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = "$"
    }
    
    @IBAction func SliderAction(_ sender: Any) {
        initialPriceTextField.resignFirstResponder()
        let value: Int = Int((slider.value)*100)
        percentageTipLabel.text = "(\(value)%)"
        initialPriceTextField.text = NSString(format: "$%.2f", (price)) as String
        let percentage = Double(price * Double(value))/100
        totalPrice = percentage + price
        tipPriceLabel.text = NSString(format: "$%.2f", (percentage)) as String
        totalPriceLabel.text = NSString(format: "$%.2f", totalPrice) as String
        let perPersonPrice = (totalPrice / splitStepper.value)
        totalPerPersonLabel.text = NSString(format: "$%.2f", perPersonPrice) as String
    }
    
    @IBAction func splitBetween(_ sender: UIStepper) {
        splitPersonsLabel.text = "\(Int(sender.value))"
        let result = totalPrice / sender.value
        totalPerPersonLabel.text = NSString(format: "$%.2f", (result)) as String
    }
}
