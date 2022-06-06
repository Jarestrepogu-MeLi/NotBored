//
//  Activity.swift
//  NotBored
//
//  Created by Mariano Martin Battaglia on 06/06/2022.
//

import Foundation

struct Activity: Decodable {
    let activity: String
    let accessibility: Double
    let type: String // Enum para type ??
    let participants: Int
    let price: Double
}
