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
        setupUI()
        addDoneButtonOnNumpad(textField: participantsTextField)
    }
    
    private func setupUI() {
        participantsTextField.delegate = self
        startButton.isEnabled = false
        startButton.backgroundColor = UIColor.gray
        startButton.layer.cornerRadius = CGFloat(6)
        startButton.alpha = 0.5
    }
    
    @IBAction func onTapStart(_ sender: Any) {
        coordinator.pushToActivityView(participants: participants ?? 0)
    }
    
    
    @IBAction func onTapTermsAndConditions(_ sender: Any) {
        present(TermsAndConditionsViewController(), animated: true, completion: nil)
    }
    
}
