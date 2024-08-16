//
//  SettingsView.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 19/08/2024.
//

import SwiftUI
import SDWebImageSwiftUI
import PhotosUI

struct SettingsAdminView: View {
    
    @StateObject var authViewModel = Auth_ADMIN_Viewmodel()
    @EnvironmentObject var coordinator: CoordinatorView
    @StateObject var adminViewModel: AdminViewModel
    
    @State private var isValidPhone = true
    @StateObject private var keyBoard = KeyboardResponder()
    @State private var isPressAlarm: Bool = false
    @State  private var isEditor: Bool = false
    @State private var photoPickerItems: PhotosPickerItem? = nil
    //    May be color must be  text color yellow?
    var body: some View {
        
        GeometryReader(content: { geometry in
            ScrollViewReader { proxy in
                
                
                ScrollView {
                    
                    VStack(alignment: .center, spacing: 20) {
                        
                        LazyVStack {
                            VStack {
                                
                                HStack(alignment: .center, spacing: 10) {
                                    PhotosPicker(selection: $photoPickerItems, matching: .images) {
                                        
                                        if let image = adminViewModel.adminProfile.image,
                                           let url = URL(string: image) {
                                            
                                            WebImage(url: url)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.3 / 2)
                                                .clipShape(Circle())
                                        } else {
                                            Image("ab3")
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.3 / 2)
                                                .clipShape(Circle())
                                        }
                                    }
                                    
                                    VStack(spacing: 10) {
                                        
                                        Text(adminViewModel.adminProfile.companyName)
                                            .font(.system(size: 24, weight: .semibold))
                                            .lineLimit(2)
                                        
                                        Text(adminViewModel.adminProfile.email)
                                        
                                    }.foregroundStyle(Color(hex: "F3E3CE"))
                                        .frame(width: 200, height: 100)
                                    
                                }.frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.25, alignment: .leading)
                                
                                
                            } .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.2)
                                .background(.ultraThickMaterial.opacity(0.6), in: .rect(topLeadingRadius: 35,
                                                                                        topTrailingRadius: 35))
                            VStack(spacing: 14) {
                                VStack(spacing: 4) {
                                    
                                    SettingsButton(text: $adminViewModel.adminProfile.companyName, title: "Compane name", width: geometry.size.width * 1)
                                    SettingsButton(text: $adminViewModel.adminProfile.name, title: "Name", width: geometry.size.width * 1)
                                    SettingsButton( text: Binding(
                                        get: { adminViewModel.adminProfile.phone },
                                        set: { newValue in
                                            adminViewModel.adminProfile.phone = formatPhoneNumber(newValue)
                                        }
                                    ), title: "Phone +(380)-000-000-00-00", width: 0)
                                    .foregroundColor(isValidPhone ? Color.gray : Color.red)
                                    .onChange(of: adminViewModel.adminProfile.phone) { newValue in
                                        isValidPhone = isValidPhoneNumber(newValue)
                                    }
                                    .keyboardType(.numberPad)
                                    .textContentType(.telephoneNumber)
                                    
                                    
                                    if !isValidPhone {
                                        Text("Invalid phone number format.")
                                            .foregroundColor(.red)
                                            .font(.caption)
                                    }
                                    SettingsButton(text: $adminViewModel.adminProfile.adress, title: "Adress", width: geometry.size.width * 1)
                                    
                                    Text("Description about Company").opacity(0.6)
                                        .font(.system(size: 16, weight: .semibold))
                                    TextEditor(text: $adminViewModel.adminProfile.description).id("text")
                                        .scrollContentBackground(.hidden)
                                        .padding(.leading, 6)
                                    
                                }.padding(.top, 6)
                                .onChange(of: isEditor, perform: { editor in
                                    if editor {
                                        withAnimation {
                                            proxy.scrollTo("text", anchor: .center)
                                        }
                                    }
                                    
                                }).onTapGesture {
                                    isEditor = true
                                    UIApplication.shared.endEditing(true)
                                    isEditor = false
                                }
                                
                            }.frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.55)
                                .background(.ultraThickMaterial.opacity(0.6), in: .rect(bottomLeadingRadius: 35,
                                                                                        bottomTrailingRadius: 35))
                                .foregroundStyle(Color(hex: "F3E3CE"))
                            
                        }.padding(.bottom, geometry.size.height * 0.03)
                        //              Button
                        VStack {
                            HStack {
                                Button(action: {
                                    Task {
                                        
                                        await adminViewModel.setNew_Admin_Profile()
                                    }
                                    
                                }, label: {
                                    Text("Save change")
                                        .foregroundStyle(Color.green)
                                        .frame(width: 140)
                                })
                                
                                Text("|")
                                    .foregroundStyle(Color.white).opacity(0.4)
                                    .fontWeight(.bold)
                                
                                Button(action: { isPressAlarm = true }, label: {
                                    Text("Sign out")
                                        .foregroundStyle(Color.red)
                                        .frame(width: 140)
                                })
                                
                            }.padding(.all).opacity(0.8)
                            
                        }.background(.ultraThickMaterial.opacity(0.6), in: .rect(topLeadingRadius: 10,
                                                                                 bottomLeadingRadius: 40,
                                                                                 bottomTrailingRadius: 40,
                                                                                 topTrailingRadius: 10))
                        .padding(.bottom, 60)
                        
                    }.padding(.bottom, keyBoard.currentHeight / 2)
                }.scrollIndicators(.hidden)
            }
            
        }).ignoresSafeArea(.keyboard, edges: .all)
            .customAlert(isPresented: $isPressAlarm, message: "Are you sure you want to exit?", title: "Leave session", onConfirm: {
                
                authViewModel.signOut()
                coordinator.popToRoot()
                
            }, onCancel: {
                
            })
            .onChange(of: photoPickerItems) { _ in
                guard let uid = authViewModel.auth.currentUser?.uid else { return }
                Task {
                    if let photoPickerItems,
                       let data = try? await photoPickerItems.loadTransferable(type: Data.self) {
                        if UIImage(data: data) != nil {
                            
                            if let url = await Admin_DataBase.shared.upDatedImage_URL_Firebase_Admin(imageData: data) {
                                await Admin_DataBase.shared.uploadImageFireBase_Admin(id: uid, url: url)
                                
                            }
                        }
                    }
                    photoPickerItems = nil
                }
                
            }.createBackgrounfFon()
        
            .onDisappear {
                Admin_DataBase.shared.deinitListener()
                SDImageCache.shared.clearMemory()
                SDImageCache.shared.clearDisk()
                
            }
        
    }
}

#Preview {
    SettingsAdminView(adminViewModel: AdminViewModel.shared)
    
}


//extension SettingsView: isFormValid {
//    var isFarmValid: Bool {
//        return !authMaster.signInViewmodel.fullName.isEmpty
//        && !authMaster.signInViewmodel.phone.isEmpty
//        && !authMaster.signInViewmodel.email.isEmpty
//        && authMaster.signInViewmodel.password.count > 6
//    }
//
//
//}
