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
        self.showSpinner()
        networkManager.fetchActivity(with: participants ?? 0, type: categories.allCases[indexPath.row].rawValue.lowercased(), completion: { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let activity):
                    self.coordinator?.goToActivity(activity, participants: self.participants!, isRandom: false)
                    print(activity)
                case .failure(let error):
                    self.showAlert(label: "No activity found.", delay: 0.5, animated: true)
                    print(error)
                }
                self.removeSpinner()
            }
        })
    }    
}
