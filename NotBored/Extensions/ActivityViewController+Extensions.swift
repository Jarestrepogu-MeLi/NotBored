//
//  ActivityViewController+Extensions.swift
//  NotBored
//
//  Created by Mariano Martin Battaglia on 09/06/2022.
//

import UIKit

extension ActivityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = activityTable.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
        cell.activityTitle.text = categories.allCases[indexPath.row].rawValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let activityURL = networkManager.searchActivityURL(participants: participants ?? 0, type: categories.allCases[indexPath.row].rawValue.lowercased())
        self.showSpinner()
        networkManager.request(url: activityURL, expecting: Activity.self, completionHandler: { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let activity):
                    self.coordinator?.goToActivity(activity, participants: self.participants!, isRandom: false)
                    print(activity)
                case .failure(let error):
                    let alert = UIAlertController(title: "No activity found.", message: "", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.dismiss(animated: true)
                    })
                    print(error)
                }
                self.removeSpinner()
            }
        })
    }
}
