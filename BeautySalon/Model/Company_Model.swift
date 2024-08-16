//
//  AdminModel.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 17/08/2024.
//

import Foundation

struct Company_Model: Identifiable, Codable, Hashable {
    
    let id: String?
    let name: String?
    let companyName: String?
    let email: String?
    let phone: String?
    let image: String?
    
    var admin_Model_FB: [String: Any] {
        var repses = [String: Any]()
        repses["id"] = self.id
        repses["name"] = self.name
        repses["companyName"] = self.companyName
        repses["email"] = self.email
        repses["phone"] = self.phone
        repses["image"] = self.image
        return repses
    }
}
