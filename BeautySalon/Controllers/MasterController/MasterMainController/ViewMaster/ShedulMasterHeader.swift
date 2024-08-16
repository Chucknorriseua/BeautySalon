//
//  ShedulMasterHeader.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 23/08/2024.
//

import SwiftUI

struct ShedulMasterHeader: View {
    
    @ObservedObject var viewModel: CalendarViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(viewModel.currentDate.format("MMMM"))
                    Text(viewModel.currentDate.format("YYYY"))
                }
                .foregroundStyle(Color.yellow)
                .font(.title.bold())
                
                Text(viewModel.currentDate.formatted(date: .complete, time: .omitted))
                    .foregroundStyle(Color.white)
                    .font(.callout)
                
                TabView(selection: $viewModel.currentWeekIndex) {
                    ForEach(viewModel.weekSlider.indices, id:\.self) { index in
                        let week = viewModel.weekSlider[index]
                        WeekView(week: week, currentDate: $viewModel.currentDate)
                            .padding(.horizontal, 15)
                            .tag(index)
                    }
                }
                .padding(.horizontal, -15)
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 78)
            }
            .padding(15)
            .hSpace(.leading)
            .padding(.trailing, 8)
            .onChange(of: viewModel.currentWeekIndex) { new in
                if new == 0 || new == (viewModel.weekSlider.count - 1) {
                    viewModel.createWeek = true
                    
                }
                viewModel.paginationWeek()
            }
        }
    }
}

#Preview(body: {
    ShedulMasterHeader(viewModel: CalendarViewModel.shared)
})
