//
//  ClientSelectedComapnyController.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 17/08/2024.
//

import SwiftUI

struct UserSelectedComapnyController: View {
    
    @StateObject var clientViewModel: ClientViewModel
    
    @EnvironmentObject var coordinator: CoordinatorView
    @State private var searchText: String = ""
    
    
    private var searchCompany: [Company_Model] {
        searchText.isEmpty ? clientViewModel.comapny : clientViewModel.comapny.filter({$0.companyName.localizedCaseInsensitiveContains(searchText)})
    }
    
    
    var body: some View {
        VStack {
            
            VStack {
                ScrollView {
                    VStack {
                        
                        ForEach(searchCompany, id:\.self) { company in
                            NavigationLink(destination: UserMainForSheduleController().navigationBarBackButtonHidden(true)) {
                                
                                CompanyAllCell(companyModel: company)
                            }
                            
                        }.padding(.bottom, -60)
                        
                    }
                }
            }.scrollIndicators(.hidden)
          .createBackgrounfFon()
            
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
                    
                    Button(action: {
                        coordinator.pop()
                    }, label: {
                        HStack(spacing: -8) {
                            Image(systemName: "arrow.left.to.line.compact")
                                .font(.system(size: 18))
                            Text("Back")
                            
                        }.foregroundStyle(Color.white)
                    })
                }
            })
            .foregroundStyle(Color.white)
            .tint(.yellow)
    }
        
}

#Preview {
    UserSelectedComapnyController(clientViewModel: ClientViewModel.shared)
}
