//
//  CalendarAddTask.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 21/08/2024.
//

import SwiftUI
import FirebaseFirestore

struct CalendarAddTask: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var adminCalendarViewModel: Admin_CalendarViewModel
    
    @State private var taskTitle: String = ""
    @State private var taskService: String = ""
    @State private var taskColor: String = "Color"
    @State var masterModel: MasterModel
    
    var body: some View {
        GeometryReader { geo in
            
            VStack(alignment: .center, spacing: 20,  content: {
                
                Button { dismiss() } label: {
                    Image(systemName: "xmark.circle.fill")
                        .tint(Color.white)
                        .font(.system(size: 20))
                        .padding(.all, 2)
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                }.background(Color.red, in: .rect(bottomLeadingRadius: 44, bottomTrailingRadius: 44))
                
                
                VStack(alignment: .leading) {
                    
                    TextField("Name Client", text: $taskTitle)
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.vertical, 14)
                    
                    TextField("Service", text: $taskService)
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.vertical, 14)
                    
                }.padding(.leading, 10)
                    .tint(Color.white)
                    .foregroundStyle(Color.white)
                
                HStack(spacing: -12) {
                    HStack() {
                        
                        DatePicker("", selection: $adminCalendarViewModel.currentDate)
                            .datePickerStyle(.compact)
                        
                    }.padding(.trailing)
                    
                    VStack()  {
                        
                        let colors: [String] = (1...5).compactMap { index -> String in
                            return "Color\(index)"
                        }
                        HStack {
                            ForEach(colors, id:\.self) { color in
                                Circle()
                                    .fill(Color(color))
                                    .frame(width: 25, height: 25)
                                    .background(content: {
                                        Circle()
                                            .stroke(lineWidth: 6)
                                            .foregroundStyle(Color.white)
                                            .opacity(taskColor == color ? 1 : 0)
                                    }).contentShape(.rect)
                                    .onTapGesture {
                                        withAnimation(.snappy) {
                                            taskColor = color
                                        }
                                    }
                            }
                        }
                    }.padding(.trailing, 16)
                    
                }
                HStack {
                    CustomButtonColor(bd: taskColor ,title: "Add") {
                        Task {
                            
                            let shedul = Shedule(id: UUID().uuidString, masterId: masterModel.masterID, taskTitle: taskTitle, taskService: taskService, creationDate: adminCalendarViewModel.currentDate, tint: taskColor, timesTamp: Timestamp(date: Date()))
                            await Admin_CalendarViewModel.shared.addTaskShedule(masterID: masterModel.masterID, addTask: shedul)
                        }
                        
                        
                        dismiss()
                    }
                }.padding(.leading, 12)
                Spacer()
            })
            .createBackgrounfFon()
        }
    }
}
