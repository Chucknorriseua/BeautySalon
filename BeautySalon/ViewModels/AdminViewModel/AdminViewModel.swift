//
//  AdminViewModel.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 20/08/2024.
//

import SwiftUI

 class AdminViewModel: ObservableObject {
     
    static var shared = AdminViewModel()
     
    init() {}
     
     @Published var productTask: [Shedule] = []

    
    func addToMaster(addMaster: Shedule) {
    productTask.append(addMaster)
        
    }
 
}
