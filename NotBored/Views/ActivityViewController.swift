//
//  ActivityViewController.swift
//  NotBored
//
//  Created by Jorge Andres Restrepo Gutierrez on 7/06/22.
//

import UIKit

class ActivityViewController: UIViewController {
    
    @IBOutlet weak var activityTable: UITableView!
    
    let networkManager = NetworkManager()
    
    var coordinator: ActivityViewCoordinator!
    
    var participants: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityTable.delegate = self
        activityTable.dataSource = self
        
        setupTable()
        
        self.title = "Activities"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "shuffle"), landscapeImagePhone: UIImage(systemName: "shuffle"), style: .plain, target: self, action: #selector(randomActivity(_:)))
    }
    
    private func setupTable() {
        activityTable.register(UINib(nibName: "ActivityCell", bundle: .main), forCellReuseIdentifier: "ActivityCell")
        var navBarHeight: CGFloat {
                return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                    (self.navigationController?.navigationBar.frame.height ?? 0.0)
        }
        activityTable.rowHeight = (activityTable.frame.height - navBarHeight) / CGFloat(categories.allCases.count)
    }
    
    @objc private func randomActivity(_ sender: UIButton) {
        let activityURL = networkManager.searchActivityURL(participants: participants ?? 0, type: nil)
        self.showSpinner()
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
                self.removeSpinner()
            }
        })
    }
    
}

