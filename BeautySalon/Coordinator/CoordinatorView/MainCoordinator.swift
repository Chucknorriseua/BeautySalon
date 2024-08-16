//
//  MainCoordinator.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 20/08/2024.
//

import SwiftUI
//
//enum UserRol: Identifiable {
//    case admin, master, user
//    
//    var id: Int {
//        hashValue.self
//    }
//}
struct MainCoordinator: View {
//    
//    @StateObject var adminCoordinator = AdminCoordinator()
//    @StateObject var masterCoordinator = MasterCoordinator()
//    @StateObject var clientCoordinator = ClientCoordinator()
//    
//    @State var selectedRole: UserRol?
    
    @EnvironmentObject var coordinator: CoordinatorView
    
    var body: some View {
        NavigationStack {
            
            VStack {
                VStack(alignment: .center, spacing: -20) {
                    
                    MainButtonSignIn(image: "person.wave.2.fill", title: " Login as Admin") {
                        coordinator.push(page: .Admi_signIN)
//                        selectedRole = .admin
                    }
                    
                    MainButtonSignIn(image: "rectangle.portrait.and.arrow.right.fill", title: " Login as Master") {
//                        selectedRole = .master
                        coordinator.push(page: .Master_SignIN)
                    }
                    
                    MainButtonSignIn(image: "person.crop.square.fill", title: "Login as Client") {
//                        selectedRole = .user
                        coordinator.push(page: .User_SignIn)
                    }
                }  // Hidden NavigationLink to trigger navigation
//                .navigationDestination(isPresented: Binding<Bool>(
//                    get: { selectedRole != nil },
//                    set: { if !$0 { selectedRole = nil } }
//                )) {
//                    if let role = selectedRole {
//                        destinationView(for: role)
//                    }
//                }
                .padding()
                Button {
                    coordinator.push(page: .Main_Reg_Profile)
                } label: {
                    Text("If you don't have an account, create one.")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.white)
    
                }

//                NavigationLink {
//                    
//                    coordinator.push(page: .Main_Reg_Profile)
//                    
//                } label: {
//                    
//                    Text("If you don't have an account, create one.")
//                        .font(.system(size: 24, weight: .bold))
//                        .foregroundStyle(Color.white)
//                }
//            }.overlay(content: {
////                AnimationMainController().padding(.bottom, 400)
//            })
//            .navigationBarTitleDisplayMode(.inline).toolbar {
//                ToolbarItem(placement: .principal) {
//                    Text("Welcom in Beauty Salon")
//                        .foregroundStyle(Color.white.opacity(0.8))
//                        .font(.system(size: 27, weight: .heavy).bold())
//                }
            }
            .createFrame()
        }
    }
    
//    @ViewBuilder
//    private func destinationView(for role: UserRol?) -> some View {
//        switch role {
//        case .admin:
//            AdminCoordinatoView().environmentObject(adminCoordinator)
//        case .master:
//            MasterCoordinatorView().environmentObject(masterCoordinator)
//        case .user:
//            ClientCoordinatorView().environmentObject(clientCoordinator)
//        case .none:
//            EmptyView()
//        }
//    }
    
}
