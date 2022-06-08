//
//  ActivityViewController.swift
//  NotBored
//
//  Created by Jorge Andres Restrepo Gutierrez on 7/06/22.
//

import UIKit

class ActivityViewController: UIViewController {
    
    var networkManager = NetworkManager()
    
    @IBOutlet weak var activityTable: UITableView!
    
    var coordinator: ActivityViewCoordinator!
    
    var participants: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityTable.delegate = self
        activityTable.dataSource = self
        
        self.title = "Activities"
        
        setupTable()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "shuffle"), landscapeImagePhone: UIImage(systemName: "shuffle"), style: .done, target: self, action: #selector(randomActivity(_:)))
    }
    
    func setupTable() {
        activityTable.register(UINib(nibName: "ActivityCell", bundle: .main), forCellReuseIdentifier: "ActivityCell")
        activityTable.rowHeight = (activityTable.frame.height / CGFloat(categories.allCases.count))
    }
    
    @objc private func randomActivity(_ sender: UIButton) {
        let activityURL = networkManager.searchActivityURL(participants: participants ?? 0, type: nil)
        networkManager.request(url: activityURL, expecting: Activity.self, completionHandler: { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let activity): //Considerar poner un spinner
                    self.coordinator?.goToActivity(activity, participants: self.participants!, isRandom: true)
                    print(activity)
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
    
}

//MARK: -> TableView
extension ActivityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = activityTable.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
        cell.activityTitle.text = categories.allCases[indexPath.row].rawValue
        cell.accessoryType = .disclosureIndicator
        
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
                    self.removeSpinner()
                    self.coordinator?.goToActivity(activity, participants: self.participants!, isRandom: false)
                    print(activity)
                case .failure(let error):
                    self.removeSpinner()
                    let alert = UIAlertController(title: "No activity found.", message: "", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.dismiss(animated: true)
                    })
                    print(error)
                }
            }
        })
    }
}
