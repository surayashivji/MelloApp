//
//  MLODatePickerViewController.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 3/9/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class MLODatePickerViewController: MLOOnboardingViewController, UITextFieldDelegate {
    @IBOutlet weak var monthField: UITextField!
    @IBOutlet weak var dayField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [monthField, dayField, yearField].forEach { tf in
            tf?.delegate = self
            tf?.addTarget(self, action: #selector(editingChanged), for: UIControlEvents.editingChanged)
            let grey = UIColor(red: 0.37, green: 0.38, blue: 0.51, alpha: 1)
            let font = UIFont.systemFont(ofSize: 30, weight: .regular)
            let attributes = [NSAttributedStringKey.foregroundColor: grey,
                              NSAttributedStringKey.font: font]
            tf?.attributedPlaceholder = NSAttributedString(string: "_ _",
                                                           attributes: attributes)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text else { return false }
        let newText = NSString(string: oldText).replacingCharacters(in: range, with: string)
        if newText == "" {
            guard let char = string.cString(using: String.Encoding.utf8) else { return false }
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                
            }
            return true
        }
        // Don't permit non-numbers to be pasted in
        guard let numericalValue = Int(newText) else { return false }
        switch textField {
        case monthField:
            return (0...12).contains(numericalValue)
        case dayField:
            return (0...31).contains(numericalValue)
        case yearField:
            return (0...2100).contains(numericalValue)
        default:
            return false
        }
    }
    
    
    @objc private func editingChanged(textField: UITextField) {
        guard let monthText = monthField.text,
            let dayText = dayField.text else { return }
        // If they entered a double digit or started with 0 and entered a single digit,
        // help move them to the next field if there are more fields to complete
        if textField == monthField && monthText.count == 2 {
            dayField.becomeFirstResponder()
        } else if textField == dayField && dayText.count == 2 {
            yearField.becomeFirstResponder()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        incrementProgress()
    }
    
    private func backTextfield(textField: UITextField) {
        
    }
    
    @objc override func nextButtonTapped() {
        var components = DateComponents()
        components.year = Int(yearField.text ?? "")
        components.month = Int(monthField.text ?? "")
        components.day = Int(dayField.text ?? "")
        components.calendar = Calendar.current
        
        guard components.isValidDate else {
            alert(error: "The date you entered is invalid.")
            return
        }
        super.nextButtonTapped()
        performSegue(withIdentifier: "next", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? MLOListOptionViewController else { return }
        nextViewController.view.layoutIfNeeded()
        nextViewController.type = .timeOfDay
    }
}
