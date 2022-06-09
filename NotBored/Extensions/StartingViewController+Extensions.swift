//
//  StartingViewController+Extensions.swift
//  NotBored
//
//  Created by Mariano Martin Battaglia on 09/06/2022.
//

import UIKit

extension StartingViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let value = Int(participantsTextField.text!) else {
            return startButton.isEnabled = false
        }
        participants = value
        
        if let textField = participantsTextField.text {
            let validation = validateCharacters(number: textField)
            startButton.alpha = 1
            startButton.backgroundColor = UIColor.systemBlue
            startButton.isEnabled = validation
        } else {
            startButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func addDoneButtonOnNumpad(textField: UITextField) {
            let keypadToolbar: UIToolbar = UIToolbar()
            keypadToolbar.items=[
                UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: textField, action: #selector(UITextField.resignFirstResponder)),
                UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
            ]
            keypadToolbar.sizeToFit()
            textField.inputAccessoryView = keypadToolbar
        }
    
    private func validateCharacters(number: String) -> Bool {
        let regEx = "^[1-9][0-9]*$"
        let regExPred = NSPredicate(format: "SELF MATCHES %@", regEx)
        return regExPred.evaluate(with: number)
    }
}
