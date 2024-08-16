//
//  ClientView.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 19/08/2024.
//

import SwiftUI

struct GetAllMastersInCompany: View {
    
    @State var masterView: [MasterModel] = [.init(id: 0, name: "Jhon", email: "lososos@wdsdsds", phone: "42423423423423", image: ""),
                                            .init(id: 1, name: "Matt", email: "32321312@21121", phone: "32131312", image: ""),
                                            .init(id: 2, name: "Matt", email: "32321312@21121", phone: "32131312", image: "") ]
    
    var body: some View {
        
        NavigationView(content: {
            
            VStack {
                Text("All the company's masters")
                    .font(.system(.title, design: .serif, weight: .regular))
                    .foregroundStyle(Color.yellow)
                ScrollView {
                    
                    VStack {
                        //  MARK: Shedul For Master Calendar
                        ForEach(masterView, id: \.self) { item in
                            NavigationLink(destination: AdminAddForMasterShedule().navigationBarBackButtonHidden(true)) {
                                
                                CellMaster(shedule: item)
                            }
                        }
                    }.scrollIndicators(.hidden)
                }
                
            }
            .createFrame()
        })
    }
}

#Preview {
    GetAllMastersInCompany()
}
