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
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let networkManager = NetworkManager()
    var resultActivity: Activity?
    var participants: Int?
    var isRandom: Bool = false
    
    var priceMessage: String {
        guard let safeResult = resultActivity?.price else {
            return "Error"
        }
        switch safeResult {
        case 0:
            return "Free"
        case 0.01..<0.3:
            return "Low"
        case 0.3..<0.6:
            return "Medium"
        case 0.6...:
            return "High"
        default:
            return "Error"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInfo(resultActivity)
        
    }
    
    func setupInfo(_ activity: Activity?) {
        if let safeActivity = activity {
            participantsLabel.text = String(safeActivity.participants)
            categoryLabel.text = safeActivity.type.capitalized
            descriptionLabel.text = safeActivity.activity
            priceLabel.text = priceMessage
            self.title = isRandom ? "Random" : safeActivity.type.capitalized
        }
    }
    
    @IBAction func onTapTryAnother(_ sender: Any) {
        let activityURL = networkManager.searchActivityURL(participants: participants ?? 0, type: isRandom ? nil : resultActivity?.type ?? "")
        networkManager.request(url: activityURL, expecting: Activity.self, completionHandler: { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let activity): //Considerar poner un spinner
                    self.resultActivity = activity
                    self.setupInfo(self.resultActivity)
                    print(self.resultActivity)
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}

