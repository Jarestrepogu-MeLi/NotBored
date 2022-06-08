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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        participantsTextField.delegate = self
        startButton.isEnabled = false
    }
    
    func setupButton(participants: Int) {
        if participants <= 0 {
            startButton.isEnabled = false
        } else {
            startButton.isEnabled = true
        }
    }
    

    
    @IBAction func onTapStart(_ sender: Any) {
        // Navegacion al ActivityViewController
    }
    
    
    @IBAction func onTapTermsAndConditions(_ sender: Any) {
        // Navegacion a Terminos y Condiciones
    }
    
}


// MARK: - Extension UIFieldDelegate
extension StartingViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textField = participantsTextField.text, !textField.isEmpty {
            let validation = validateCharacters(number: textField)
            startButton.isEnabled = validation
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
        
}



