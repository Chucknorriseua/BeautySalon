//
//  HeaderCalendarView.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 21/08/2024.
//

import SwiftUI

struct CalendarMainController: View {
    
    @StateObject var viewModel: Admin_CalendarViewModel
    @State var masterModel: MasterModel
    
    var body: some View {
        GeometryReader { geo in
            
            VStack {
                HeaderView(viewModel: viewModel, masterModel: masterModel)
                ScrollView {
                    TasksForSelectedDate(viewModel: viewModel, masterModel: masterModel, currentDate: viewModel.currentDate)
                }
                .scrollIndicators(.hidden)
            
            }
        }
        .onAppear {
            viewModel.setupWeeks()
            Task {
                await Admin_CalendarViewModel.shared.fetchAllSheduleCurrentMaster(masterID: masterModel.masterID, sheduleMaster: viewModel.shedules)
            }
        }
    }
}
