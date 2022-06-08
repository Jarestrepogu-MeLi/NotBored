//
//  Constants.swift
//  NotBored
//
//  Created by Jorge Andres Restrepo Gutierrez on 7/06/22.
//

import UIKit


enum categories: String, CaseIterable {
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

struct nBColors {
    static let backgroundColor = UIColor(red: 0.875, green: 0.952, blue: 0.992, alpha: 1.0)
    static let titleColor = UIColor(red: 0.255, green: 0.561, blue: 0.886, alpha: 1.0)
    static let bodyColor = UIColor(red: 0.083, green: 0.065, blue: 0.234, alpha: 1.0)
}
