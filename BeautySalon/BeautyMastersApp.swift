//
//  BeautyMastersApp.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 16/08/2024.
//

import SwiftUI

@main
struct BeautyMastersApp: App {
    
    
    init() {
        FirebaseApp.configure()
    }

    
    var body: some Scene {
        WindowGroup {
//            AdminMainController()
            MainCoordinator()
//            AdminAddForMasterShedule()
            
        }
    }
}
