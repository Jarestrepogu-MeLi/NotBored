//
//  ActivityViewController.swift
//  NotBored
//
//  Created by Jorge Andres Restrepo Gutierrez on 7/06/22.
//

import UIKit

final class ActivityViewModel {
    
    let networkManager = NetworkManager()
    var participants: Int?
    var coordinator: ActivityViewCoordinator!
    
    var isLoading: Bool = false {
        didSet { isLoadingHandler?(isLoading) }
    }
    var tryAgain: Bool = false {
        didSet { showAlert?(tryAgain) }
    }
    
    var isLoadingHandler: ((Bool) -> Void)?
    var showAlert: ((Bool) -> Void)?
    
    func fetchRandomActivity () {
        isLoading = true
        networkManager.fetchActivity(with: participants!, type: nil, completion: { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let activity):
                    self.coordinator?.goToActivity(activity, participants: self.participants!, isRandom: true)
                case .failure(let error):
                    print(error)
                }
            }
        })
        isLoading = false
    }
    
    func fetchActivity(category: String) {
        networkManager.fetchActivity(with: participants ?? 0, type: category, completion: { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let activity):
                    self.coordinator?.goToActivity(activity, participants: self.participants!, isRandom: false)
                case .failure(let error):
                    self.tryAgain = true
                    print(error)
                }
            }
        })
    }
}

final class ActivityViewController: UIViewController {
    
    @IBOutlet weak var activityTable: UITableView!
    
    let viewModel = ActivityViewModel()
    
    //    let networkManager = NetworkManager()
    //    var coordinator: ActivityViewCoordinator!
    //    var participants: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityTable.delegate = self
        activityTable.dataSource = self
        
        viewModel.isLoadingHandler = { [unowned self] isLoading in
            isLoading ? self.showSpinner() : self.removeSpinner()
        }
        viewModel.showAlert = { [unowned self] alert in
            self.showAlert(label: "No activity found.", delay: 0.5, animated: true)
        }
        
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
        viewModel.fetchRandomActivity()
        //        self.showSpinner()
        //        networkManager.fetchActivity(with: participants!, type: nil, completion: { [weak self] result in
        //            DispatchQueue.main.async {
        //                guard let self = self else { return }
        //                switch result {
        //                case .success(let activity):
        //                    self.coordinator?.goToActivity(activity, participants: self.participants!, isRandom: true)
        //                    print(activity)
        //                case .failure(let error):
        //                    self.showAlert(label: "Please try again.", delay: 0.5, animated: true)
        //                    print(error)
        //                }
        //                self.removeSpinner()
        //            }
        //        })
    }
}

