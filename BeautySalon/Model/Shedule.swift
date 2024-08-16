//
//  Shedule.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 20/08/2024.
//

import SwiftUI

struct Shedule: Identifiable, Hashable {
    
    var id: UUID
    var taskTitle: String
    var taskService: String
    var creationDate: Date
    var tint: String
    
    var tinColor: Color {
        switch tint {
        case "Color": return .white.opacity(0.7)
        case "Color1": return .blue.opacity(0.7)
        case "Color2": return .red.opacity(0.7)
        case "Color3": return .green.opacity(0.7)
        case "Color4": return .pink.opacity(0.7)
        case "Color5": return .orange.opacity(0.7)
        default:
            return .black
        }
    }
}
