//
//  AdminRegister.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 17/08/2024.
//

import SwiftUI
import FirebaseAuth
import PhotosUI

struct AdminRegister: View {
    

    @EnvironmentObject var coordinator: CoordinatorView
    @State private var photoPickerItems: PhotosPickerItem? = nil
    @StateObject var authViewModel = AuthFB_ViewModel()
    @State var isUserMessage: Bool = false
    @State var errorMessages = ""
    
    
    var body: some View {

            VStack {
                HStack {
                    
                    PhotosPicker(selection: $photoPickerItems, matching: .images) {
                        Image(uiImage: UIImage(data:  authViewModel.selectedImage ?? Data() ) ?? UIImage(resource: .ab3))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90, height: 90)
                            .clipShape(Circle())
                    }
                    
                    Text("Сhoose company logo")
                        .foregroundStyle(Color.white)
                        .font(.system(.title, design: .serif, weight: .regular))
                }
                
                
                CustomTextField(text: $authViewModel.nameCompany,
                                title: "Name Company", width: UIScreen.main.bounds.width - 20,
                                showPassword: $authViewModel.showPassword)
                
                CustomTextField(text: $authViewModel.fullName,
                                title: "Name Administrator", width: UIScreen.main.bounds.width - 20,
                                showPassword:  $authViewModel.showPassword)
                
                CustomTextField(text: $authViewModel.phone,
                                title: "Phone", width: UIScreen.main.bounds.width - 20,
                                showPassword:  $authViewModel.showPassword)
                
                CustomTextField(text: $authViewModel.email,
                                title: "Email", width: UIScreen.main.bounds.width - 20,
                                showPassword:  $authViewModel.showPassword)
                
                CustomTextField(text: $authViewModel.password,
                                title: "Password", width: UIScreen.main.bounds.width - 20,
                                showPassword:  $authViewModel.showPassword)
         
                CustomButton(title: "Register a Company") {
                    isUserMessage = true
                    errorMessages = "Create new Company..."
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        
                        Task {
                            await authViewModel.saveAdminCompany()
                            coordinator.push(page: .Admin_main)
                        }
                    }
                    
                }
//                .disabled(!isFarmValid)
//                .alert(errorMessages, isPresented: $isUserMessage, actions: {
//                    Button {} label: {
//                        Text("OK")
//                    }

//                })
                
                VStack {
                    Button(action: {
                        coordinator.pop()
                        
                    }, label: {
                        Image(systemName: "arrow.left.to.line")
                        Text("Back to Sign In")
                    }).foregroundStyle((Color.white))
                      .font(.title2.bold())
                }
            }.navigationBarTitleDisplayMode(.inline).toolbar {
                ToolbarItem(placement: .navigation) {
                    Text("Login as Admin")
                        .foregroundStyle(Color.white.opacity(0.9))
                        .font(.largeTitle.bold())
                }
                
            }.onChange(of: photoPickerItems ) { new in
                Task {
                    if let photoPickerItems,
                       let data = try? await photoPickerItems.loadTransferable(type: Data.self) {
                        if UIImage(data: data) != nil {
                            await MainActor.run {
                                authViewModel.selectedImage = data
                                print("Selected image printn data siza \(authViewModel.selectedImage?.count ?? 0), byte")
                            }
                           
                        }
                    }
                    photoPickerItems = nil
                }
            }
            .createFrame()
    }
}

extension AdminRegister: isFormValid {
    var isFarmValid: Bool {
        return !authViewModel.nameCompany.isEmpty
        && !authViewModel.fullName.isEmpty
        && !authViewModel.phone.isEmpty
        && !authViewModel.email.isEmpty
        && authViewModel.password.count > 6
    }
    
    
}

#Preview {
    AdminRegister()
}
