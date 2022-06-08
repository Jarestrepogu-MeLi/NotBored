//
//  CoordinatorProtocol.swift
//  NotBored
//
//  Created by Mariano Martin Battaglia on 07/06/2022.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

extension Coordinator {
    func start() {
        
    }
}
