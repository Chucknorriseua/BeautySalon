//
//  UserSelectedComapnyController.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 17/08/2024.
//

import SwiftUI
import CoreLocation

struct UserSelectedComapnyController: View {
    
    @StateObject var clientViewModel: ClientViewModel
    @StateObject var locationManager = LocationManager()
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var coordinator: CoordinatorView
    @State private var searchText: String = ""
    @State private var loader: String = "Loader"
    @State private var isLoader: Bool = false
    
    
    
    
    private var searchCompanyNearby: [Company_Model] {
        guard let userLocation = locationManager.locationManager.location else {
            return  searchText.isEmpty ? clientViewModel.comapny :
           clientViewModel.comapny.filter({$0.companyName.localizedCaseInsensitiveContains(searchText)})
        }
        
        let radius: CLLocationDistance = 10000
        return clientViewModel.comapny.filter { company in
            let matchesName = searchText.isEmpty ||  company.companyName.localizedCaseInsensitiveContains(searchText)
            let isNearby: Bool
            if let distance = locationManager.calculateDistance(from: userLocation, to: company) {
                isNearby = distance <= radius
            } else {
                isNearby = false
            }
            return matchesName && isNearby
        }
    }
    
    var body: some View {
        VStack {
            
            VStack {
                ScrollView {
                    LazyVStack {
                        
                        ForEach(searchCompanyNearby, id:\.self) { company  in
                            NavigationLink(destination: UserMainForSheduleController(clientViewModel: clientViewModel).navigationBarBackButtonHidden(true)) {
                                withAnimation {
                                    
                                    Button {
                                        isLoader = true
                                        Task {
                                            clientViewModel.adminProfile.adminID = company.adminID
                                            await clientViewModel.fetchCurrent_AdminSalon(adminId: company.adminID)
                                            
                                            coordinator.push(page: .User_SheduleAdmin)
                                            isLoader = false
                                        }
                                    } label: {
                                        CompanyAllCell(companyModel: company)
                               
                                    }
                                }
                            }.id(company)
                                .padding(.bottom, 40)
                                .scrollTransition(.interactive) { content, phase in
                                    withAnimation(.snappy(duration: 1)) {
                                        
                                        content
                                            .opacity(phase.isIdentity ? 1 : 0)
                                            .offset(y: phase.isIdentity ? 0 : -80)
                                    }
                                }
                            
                        }
                    }.scrollTargetLayout()
                }
            }.scrollIndicators(.hidden)
                .scrollContentBackground(.hidden)
                .createBackgrounfFon()
                .overlay(alignment: .center) { CustomLoader(isLoader: $isLoader, text: $loader) }

        }.searchable(text: $searchText)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(alignment: .center) {
                        Text("Choose Salon")
                            .foregroundColor(.yellow)
                            .font(.system(size: 24, weight: .bold, design: .serif))
                    }
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    TabBarButtonBack {
                        Task {
                            try await GoogleSignInViewModel.shared.logOut()
                            Auth_ClientViewModel.shared.signOutClient()
                            coordinator.popToRoot()
                        }
                    }
                }
            })
            .foregroundStyle(Color.white)
            .tint(.yellow)
            .onAppear {
                locationManager.isUpdateLocation = true
                locationManager.startUpdate()
                Task {
                await clientViewModel.fetchAll_Comapny()
                }
            }
            .onDisappear {
                locationManager.isUpdateLocation = false
                locationManager.stopUpdate()
            }
    }
    
}
