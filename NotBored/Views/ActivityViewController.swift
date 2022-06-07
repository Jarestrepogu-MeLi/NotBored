//
//  ActivityViewController.swift
//  NotBored
//
//  Created by Jorge Andres Restrepo Gutierrez on 7/06/22.
//

import UIKit

enum categories: String {  //Organizar en un lugar apropiado
    case education = "Education",
         recreational = "Recreational",
         social = "Social",
         diy = "Diy",
         charity = "Charity",
         cooking = "Cooking",
         relaxation = "Relaxation",
         music = "Music",
         busywork = "Busywork"
}

class ActivityViewController: UIViewController {
    
    let networkManager = NetworkManager()
    
    @IBOutlet weak var activityTable: UITableView!
    
    
    let categoriesLabels = ["Education", "Recreational", "Social", "Diy", "Charity", "Cooking", "Relaxation", "Music", "Busywork"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityTable.delegate = self
        activityTable.dataSource = self
        setupTable()
    }
    
    func setupTable() {
        activityTable.register(UINib(nibName: "ActivityCell", bundle: .main), forCellReuseIdentifier: "ActivityCell")
        activityTable.rowHeight = (activityTable.frame.height / CGFloat(categoriesLabels.count))
    }
}

//MARK: -> TableView
extension ActivityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = activityTable.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
        cell.activityTitle.text = categoriesLabels[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activityURL = networkManager.searchActivityURL(participants: 1, type: categoriesLabels[indexPath.row].lowercased())
        networkManager.request(url: activityURL, expecting: Activity.self, completionHandler: { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let activity): //Considerar poner un spinner
                    
                    print(activity)
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}
