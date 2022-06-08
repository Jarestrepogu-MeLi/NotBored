//
//  ActivityViewCoordinator.swift
//  NotBored
//
//  Created by Jorge Andres Bernal Palacio on 8/06/22.
//

import UIKit

class ActivityViewCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goToActivity(_ activity: Activity, participants: Int, isRandom: Bool) {
        let vc = SuggestionViewController()
        vc.resultActivity = activity
        vc.participants = participants
        vc.isRandom = isRandom
        navigationController.pushViewController(vc, animated: true)
    }
}
