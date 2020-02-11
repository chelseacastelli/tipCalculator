//
//  ViewController.swift
//  TipCalculatorStarter
//
//  Created by Chase Wang on 9/19/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!
    
    @IBOutlet weak var inputCardView: UIView!
    @IBOutlet weak var billAmountTextField: BillAmountTextField!
    @IBOutlet weak var tipPercentSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var outputCardView: UIView!
    @IBOutlet weak var tipAmountTitleLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountTitleLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!
    
    
    // MARK: - View Lifecycle
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
        billAmountTextField.calculateButtonAction = {
            self.calculate()
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func themeToggled(_ sender: UISwitch) {
        if sender.isOn {
            print("switch toggled on")
        } else {
            print("switch toggled off")
        }
    }
    
    @IBAction func tipPercentChanged(_ sender: UISegmentedControl) {
        calculate()
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        clear()
    }
    
    func calculate() {
        // Dismiss Keyboard
        if self.billAmountTextField.isFirstResponder {
            self.billAmountTextField.resignFirstResponder()
        }
        
        guard let billAmountText = self.billAmountTextField.text,
            let billAmount = Double(billAmountText) else {
                clear()
                return
        }
        
        let roundedBillAmount = (100 * billAmount).rounded() / 100
        
        let tipPercent: Double
        switch tipPercentSegmentedControl.selectedSegmentIndex {
        case 0:
            tipPercent = 0.20
        case 1:
            tipPercent = 0.23
        case 2:
            tipPercent = 0.25
        default:
            preconditionFailure("Unexpected index.")
        }
        
        let tipAmount = roundedBillAmount * tipPercent
        let roundedTipAmount = (100 * tipAmount).rounded() / 100
        
        let totalAmount = roundedBillAmount + roundedTipAmount
        
        // Update UI
        self.billAmountTextField.text = String(format: "%.2f", roundedBillAmount)
        self.tipAmountLabel.text = String(format: "%.2f", roundedTipAmount)
        self.totalAmountLabel.text = String(format: "%.2f", totalAmount)
    }
    
    func clear() {
        self.billAmountTextField.text = nil
        self.tipAmountLabel.text = "$0.00"
        self.totalAmountLabel.text = "$0.00"
        
        tipPercentSegmentedControl.selectedSegmentIndex = 0
    }
    
    func setUpViews() {
        
        // iOS 13+ doesn't allow tint color to be changed in attributes inspector
        // Must set selected segment background color programatically
        if #available(iOS 13.0, *) {
            tipPercentSegmentedControl.selectedSegmentTintColor = UIColor.tcHotPink
        } else {
            // Fallback on earlier versions
        }
        
        tipPercentSegmentedControl.layer.borderWidth = 1
        tipPercentSegmentedControl.layer.borderColor = UIColor.tcHotPink.cgColor
        tipPercentSegmentedControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.tcDarkBlue], for: .selected)
        tipPercentSegmentedControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.tcHotPink], for: .normal)
        
        headerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        headerView.layer.shadowOpacity = 0.05
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowRadius = 35
        
        inputCardView.layer.cornerRadius = 8
        inputCardView.layer.masksToBounds = true
        
        outputCardView.layer.cornerRadius = 8
        outputCardView.layer.masksToBounds = true
        outputCardView.layer.borderWidth = 1
        outputCardView.layer.borderColor = UIColor.tcHotPink.cgColor
        
        resetButton.layer.cornerRadius = 8
        resetButton.layer.masksToBounds = true
    }
    
    
    
}

