//
//  ClientView.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 19/08/2024.
//

import SwiftUI

struct GetAllMastersInCompany: View {
    
    @ObservedObject var adminViewModel: AdminViewModel

    
    var body: some View {
        
        NavigationView(content: {
            GeometryReader { geometry in
                
                VStack {
                    Text("All the company's masters")
                        .font(.system(.title, design: .serif, weight: .regular))
                        .foregroundStyle(Color.yellow)
                    ScrollView {
                        
                        LazyVStack {
                            //  MARK: Shedul For Master Calendar
                            ForEach(adminViewModel.addMasterInRoom, id: \.id) { item in
                                NavigationLink(destination: AdminAddForMasterShedule(adminViewModel: adminViewModel,
                                                                                     masterModel: item).navigationBarBackButtonHidden(true)) {
                                    CellMaster(masterModel: item)

                                }
                            }
                            
                        }.padding(.top, 30)
                            .padding(.bottom, 50)

                    }.scrollIndicators(.hidden)
                        
                    
                }
                .createBackgrounfFon()
            }
        })
    }
}
