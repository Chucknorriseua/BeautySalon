//
//  Main_Controller_Register.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 19/08/2024.
//

import SwiftUI

//enum UserRolse: Identifiable {
//    case admin, master, user
//    
//    var id: Int {
//        hashValue.self
//    }
//}

struct Main_Controller_Register: View {
    
//    @StateObject var adminCoordinator = AdminCoordinator()
//    @StateObject var masterCoordinator = MasterCoordinator()
//    @StateObject var clientCoordinator = ClientCoordinator()
//    @Environment(\.presentationMode) var mod
    
//    @State var selectedRole: UserRolse?
    
    @EnvironmentObject var coordinator: CoordinatorView
    
    var body: some View {
            
            VStack {
                VStack(alignment: .center, spacing: -20) {
                    
                    MainButtonSignIn(image: "person.wave.2.fill", title: " Register as Admin") {
                        coordinator.push(page: .Admin_Register)
//             /* */          selectedRole = .admin
                    }
                    
                    MainButtonSignIn(image: "rectangle.portrait.and.arrow.right.fill", title: " Register as Master") {
//                        selectedRole = .master
                        coordinator.push(page: .Master_Register)
                    }
                    
                    MainButtonSignIn(image: "person.crop.square.fill", title: "Register as Client") {
                         coordinator.push(page: .User_Register)
                    }
                }
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
                    coordinator.popToRoot()
                } label: {
                    Image(systemName: "arrow.left.to.line")
                    Text("Back to Sign In")
                }.foregroundStyle((Color.white))
                 .font(.title2.bold())

            }
            .navigationBarTitleDisplayMode(.inline).toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Welcom in Beauty Salon")
                        .foregroundStyle(Color.white.opacity(0.8))
                        .font(.system(size: 27, weight: .heavy).bold())
                }
            }
            .createFrame()
        
    }
//    @ViewBuilder
//    private func destinationView(for role: UserRolse?) -> some View {
//        switch role {
//        case .admin:
//            AdminRegisterView().environmentObject(adminCoordinator)
//        case .master:
//            MasterRegisterView().environmentObject(masterCoordinator)
//        case .user:
//            RegisterClientView().environmentObject(clientCoordinator)
//        case .none:
//            EmptyView()
//        }
//    }
}
