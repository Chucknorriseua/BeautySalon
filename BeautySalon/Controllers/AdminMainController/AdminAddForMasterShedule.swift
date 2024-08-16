//
//  AdminMainController.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 17/08/2024.
//

import SwiftUI

struct AdminAddForMasterShedule: View {
    
    var body: some View {
        
        VStack {
            CalendarMainController(viewModel: CalendarViewModel.shared)
        }.padding(.bottom, 24)
            .createFrame()
    }
}

#Preview {
    AdminAddForMasterShedule()
}
