//
//  ClientModel.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 17/08/2024.
//

import Foundation

struct Client: Identifiable, Codable, Hashable {
    
    let id: Int
    let name: String
    let email: String
    let phone: String
    let date: Date    
    
}
