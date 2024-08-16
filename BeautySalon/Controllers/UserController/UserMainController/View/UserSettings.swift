//
//  UserSettings.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 03/10/2024.
//

import SwiftUI

struct UserSettings: View {
    
    @Environment (\.dismiss) private var dismiss
    @State private var taskTitle: String = ""
    @State private var taskService: String = ""
    
    @ObservedObject var clientViewModel: ClientViewModel
    
    var body: some View {
        GeometryReader { geo in
            
            VStack(alignment: .center, spacing: 10,  content: {
                
                Button { dismiss() } label: {
                    Image(systemName: "xmark.circle.fill")
                        .tint(Color.white)
                        .font(.system(size: 20))
                        .padding(.all, 2)
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                }.background(Color.red, in: .rect(bottomLeadingRadius: 44, bottomTrailingRadius: 44))
                
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    SettingsButton(text: $clientViewModel.clientModel.name, title: "Change name", width: geo.size.width * 1)
                    SettingsButton(text: $clientViewModel.clientModel.phone, title: "Phone +(000)", width: geo.size.width * 1)
                        .keyboardType(.numberPad)
                        .textContentType(.telephoneNumber)
                    SettingsButton(text: $clientViewModel.clientModel.email, title: "You'r email", width: geo.size.width * 1)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                    
                }.padding(.leading, 10)
                    .font(.system(size: 16, weight: .medium))
                    .tint(Color.white)
                    .foregroundStyle(Color.white)

                HStack {
                    MainButtonSignIn(image: "person.crop.circle.fill", title: "Save", action: {
                        Task {
                            await clientViewModel.save_UserProfile()
                            dismiss()
                        }
                    })
                }
                Spacer()
            })
            .createBackgrounfFon()
            .ignoresSafeArea(.all)
        }
    }
}

//#Preview {
//    UserSettings()
//}
