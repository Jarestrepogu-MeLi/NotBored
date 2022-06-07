//
//  SuggestionViewController.swift
//  NotBored
//
//  Created by Mariano Martin Battaglia on 07/06/2022.
//

import UIKit

class SuggestionViewController: UIViewController {
    
    @IBOutlet weak var participantsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    let networkManager = NetworkManager()
    var resultActivity: Activity?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onTapTryAnother(_ sender: Any) {
        let activityURL = networkManager.searchActivityURL(participants: 1, type: "education")
        networkManager.request(url: activityURL, expecting: Activity.self, completionHandler: { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let activity): //Considerar poner un spinner
                    self.resultActivity = activity
                    print(self.resultActivity)
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}

