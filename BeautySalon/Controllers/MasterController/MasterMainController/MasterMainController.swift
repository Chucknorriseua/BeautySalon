//
//  MasterMainController.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 17/08/2024.
//

import SwiftUI

struct MasterMainController: View {
 
    var body: some View {
        
        VStack {
            MasterViewTask(viewModel: CalendarViewModel.shared)
        }
    }
}

#Preview {
    MasterMainController()
}
