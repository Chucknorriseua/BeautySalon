//
//  UserRegisters.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 17/08/2024.
//

import SwiftUI

struct UserRegisters: View {
    
    @StateObject var signViewModel = SignInViewModel()
    @EnvironmentObject  var coordinator: CoordinatorView
    var body: some View {

            VStack {
                CustomTextField(text: $signViewModel.fullName,
                                title: "Name",
                                width: UIScreen.main.bounds.width - 20,
                                showPassword: $signViewModel.showPassword)
                
                CustomTextField(text: $signViewModel.email,
                                title: "Email",
                                width: UIScreen.main.bounds.width - 20,
                                showPassword: $signViewModel.showPassword)
                
                CustomTextField(text: $signViewModel.password,
                                title: "Password",
                                width: UIScreen.main.bounds.width - 20,
                                showPassword: $signViewModel.showPassword)
                
                CustomButton(title: "Register as Client") {
                    coordinator.push(page: .User_Main)
                }
                VStack {
                    Button(action: {
                        coordinator.popToRoot()
                        
                    }, label: {
                        Image(systemName: "arrow.left.to.line")
                        Text("Back to Sign In")
                    }).foregroundStyle((Color.white))
                      .font(.title2.bold())
                }
            }.navigationBarTitleDisplayMode(.inline).toolbar {
                ToolbarItem(placement: .navigation) {
                    Text("Login as Client")
                        .foregroundStyle(Color.white.opacity(0.9))
                        .font(.largeTitle.bold())
                }
            }
            .createFrame()
    }
}
#Preview {
    UserRegisters()
}
