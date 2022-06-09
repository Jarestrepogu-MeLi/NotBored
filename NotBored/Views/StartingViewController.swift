//
//  StartingViewController.swift
//  NotBored
//
//  Created by Mariano Martin Battaglia on 07/06/2022.
//

import UIKit

class StartingViewController: UIViewController {
    
    @IBOutlet weak var participantsTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    var participants: Int?
    
    var coordinator: MainCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeButtonColor(startButton)
        setupUI()
        addDoneButtonOnNumpad(textField: participantsTextField)
//        view.backgroundColor = UIColor.red
    }
    
    func setupUI() {
        participantsTextField.delegate = self
        startButton.isEnabled = false
    }
    
    func setupButton(participants: Int) {
        if participants <= 0 {
            startButton.backgroundColor = UIColor.gray
            startButton.isEnabled = false
        } else {
            startButton.backgroundColor = UIColor.blue
            startButton.isEnabled = true
        }
    }
    
    func changeButtonColor(_ button: UIButton) {
    }
    
    
    
    @IBAction func onTapStart(_ sender: Any) {
        coordinator.pushToActivityView(participants: participants ?? 0)
    }
    
    
    @IBAction func onTapTermsAndConditions(_ sender: Any) {
        present(TermsAndConditionsViewController(), animated: true, completion: nil)
    }
    
}


// MARK: - Extension UIFieldDelegate
extension StartingViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let value = Int(participantsTextField.text!) else { return }
        participants = value
        
        if let textField = participantsTextField.text, !textField.isEmpty {
            let validation = validateCharacters(number: textField)
            startButton.isEnabled = validation
        } else {
            startButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    func validateCharacters(number: String) -> Bool {
        let regEx = "^[1-9][0-9]*$"
        let regExPred = NSPredicate(format: "SELF MATCHES %@", regEx)
        return regExPred.evaluate(with: number)
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
    
}



