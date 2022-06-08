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
    
    func goToActivity(_ activity: Activity ) {
        let vc = SuggestionViewController()
        vc.resultActivity = activity
        navigationController.pushViewController(vc, animated: true)
    }
}
