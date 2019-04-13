//
//  superHeroLaureates.swift
//  superHeroLaureates
//
//  Created by Paudel,Saroj on 4/13/19.
//  Copyright © 2019 Paudel,Saroj. All rights reserved.
//

import Foundation

struct SuperHero: Codable {
    var members: [Members]
}

struct Members: Codable {
    var name: String
    var secretIdentity: String
    var powers: [String]
}

struct Laureates: Codable{
    var firstname: String
    var surname: String
    var born: String
    var died: String
}
