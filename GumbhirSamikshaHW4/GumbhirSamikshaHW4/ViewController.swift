//
//  ViewController.swift
//  GumbhirSamikshaHW4
//
//  Created by Samiksha Gumbhir on 9/21/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var totalTextField: UITextField!
    
    @IBOutlet weak var taxSegmented: UISegmentedControl!
    
    @IBOutlet weak var includeTax: UISwitch!
    
    @IBOutlet weak var percentageTipLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var numOfPeople: UIStepper!
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var numOfPeopleLabel: UILabel!
    
    @IBOutlet weak var taxLabel: UILabel!
    
    @IBOutlet weak var subtotalLabel: UILabel!
    
    @IBOutlet weak var tipOutputLabel: UILabel!
    @IBOutlet weak var totalWithTipLabel: UILabel!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    
    @IBOutlet weak var tipCalculator: UILabel!
    @IBOutlet weak var billLabel: UILabel!
    
    @IBOutlet weak var splitStatic: UILabel!
    @IBOutlet weak var includeTaxstatic: UILabel!
    @IBOutlet weak var segmentedLabel: UILabel!
    
    @IBOutlet weak var totalSplitStatic: UILabel!
    @IBOutlet weak var totalStatic: UILabel!
    @IBOutlet weak var tipStatic: UILabel!
    @IBOutlet weak var subtotalStatic: UILabel!
    @IBOutlet weak var taxStatic: UILabel!
    
    @IBOutlet weak var oneView: UIView!
    
    var tipValueDefault = 10
    var stepperValDefault = 1
    var includeTaxValueDefault = true
    var tax_idx = 0
    var totalAmountValue = 0.0
    var taxPercentage = 7.5
    var tipValue = 10
    var stepperVal = 1
    var includeTaxValue = true
    var subtotalValue = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalTextField.becomeFirstResponder()
        totalTextField.accessibilityIdentifier = HW4AccessibilityIdentifiers.billTextField
        taxSegmented.accessibilityIdentifier = HW4AccessibilityIdentifiers.segmentedTax
        includeTax.accessibilityIdentifier = HW4AccessibilityIdentifiers.includeTaxSwitch
        slider.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipSlider
        numOfPeople.accessibilityIdentifier = HW4AccessibilityIdentifiers.splitStepper
        resetButton.accessibilityIdentifier = HW4AccessibilityIdentifiers.resetButton
        taxLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.taxAmountLabel
        subtotalLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.subtotalAmountLabel
        tipOutputLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipAmountLabel
        totalWithTipLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalWithTipAmountLabel
        totalPerPersonLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalPerPersonAmountLabel
        percentageTipLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.sliderLabel
        numOfPeopleLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.splitLabel
        
        tipCalculator.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipCalculaterLabel
        billLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.billLabel
        segmentedLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.segmentedLabel
        includeTaxstatic.accessibilityIdentifier = HW4AccessibilityIdentifiers.includeTaxLabel
        splitStatic.accessibilityIdentifier = HW4AccessibilityIdentifiers.evenSplitLabel
        taxStatic.accessibilityIdentifier = HW4AccessibilityIdentifiers.taxLabel
        subtotalStatic.accessibilityIdentifier = HW4AccessibilityIdentifiers.subtotalLabel
        tipStatic.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipLabel
        totalStatic.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalWithTipLabel
        totalSplitStatic.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalPerPersonLabel
        
        oneView.accessibilityIdentifier = HW4AccessibilityIdentifiers.view
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func clearAllAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Clear All Values", message: "Are you sure you want to clear all values?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: clearAll)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func resignKeyboard(_ sender: UIButton) {
        totalTextField.resignFirstResponder()
    }

    @IBAction func resignOnReturn(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func numOfPeopleAction(_ sender: UIStepper) {
        stepperVal = Int(sender.value)
        numOfPeopleLabel.text = "\(stepperVal)"
        updateLabels()
    }
    
    @IBAction func tipSliderAction(_ sender: UISlider) {
        tipValue = Int(slider.value + 0.5)
        percentageTipLabel.text = "\(tipValue)%"
        updateLabels()
    }
    
    @IBAction func taxPercentageChange(_ sender: UISegmentedControl) {
        tax_idx = taxSegmented.selectedSegmentIndex
        if tax_idx == 0 {
            taxPercentage = 7.5
        }
        else if tax_idx == 1 {
            taxPercentage = 8
        }
        else if tax_idx == 2 {
            taxPercentage = 8.5
        }
        else if tax_idx == 3 {
            taxPercentage = 9
        }
        else{
            taxPercentage = 9.5
        }
        updateLabels()
    }
    
    @IBAction func includeTaxChange(_ sender: UISwitch) {
        includeTaxValue = sender.isOn
        updateLabels()
    }
    
    @IBAction func amountChanged(_ sender: UITextField) {
        if let val = sender.text{
            totalAmountValue = Double(val) ?? 0.0
            updateLabels()
        }
    }
    
    func updateLabels(){
        let taxLabelValue = (taxPercentage/100.0) * totalAmountValue
        taxLabel.text = "$\(String(format: "%.2f",taxLabelValue))"
        subtotalValue = totalAmountValue
        if(includeTaxValue){
            subtotalValue += taxLabelValue
        }
        subtotalLabel.text = "$\(String(format: "%.2f", subtotalValue))"
        let tipAmountValue = (Double(tipValue)/100.0) * subtotalValue
        tipOutputLabel.text = "$\(String(format: "%.2f", tipAmountValue))"
        let total = tipAmountValue + totalAmountValue + taxLabelValue
        totalWithTipLabel.text = "$\(String(format: "%.2f", total))"
        let totalSplit = total / Double(stepperVal)
        totalPerPersonLabel.text = "$\(String(format: "%.2f", totalSplit))"
    }
    
    func clearAll(_ sender: UIAlertAction) -> Void{
        taxLabel.text = "$0.00"
        subtotalLabel.text = "$0.00"
        tipOutputLabel.text = "$0.00"
        totalWithTipLabel.text = "$0.00"
        totalPerPersonLabel.text = "$0.00"
        resetUI()
    }
    
    func resetUI(){
        totalAmountValue = 0.0
        taxPercentage = 7.5
        tipValue = 10
        stepperVal = 1
        includeTaxValue = true
        totalTextField.text = ""
        taxSegmented.selectedSegmentIndex = 0
        includeTax.isOn = includeTaxValueDefault
        slider.value = Float(tipValueDefault)
        percentageTipLabel.text = "\(tipValue)%"
        numOfPeople.value = Double(stepperVal)
        numOfPeopleLabel.text = "\(stepperVal)"
        totalTextField.resignFirstResponder()
    }
}

