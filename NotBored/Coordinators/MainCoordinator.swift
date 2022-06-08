//
//  MainCoordinator.swift
//  NotBored
//
//  Created by Mariano Martin Battaglia on 07/06/2022.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = StartingViewController()
        vc.coordinator = self
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func pushToActivityView() {
        let vc = ActivityViewController()
        vc.coordinator = self
        
        self.navigationController.setNavigationBarHidden(false, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}
