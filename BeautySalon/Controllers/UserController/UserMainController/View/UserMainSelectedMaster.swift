//
//  UserMainSelectedMaster.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 04/10/2024.
//

import SwiftUI

struct UserMainSelectedMaster: View {
    
    @StateObject var clientViewModel: ClientViewModel
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                
                LazyVStack {
                    ForEach(clientViewModel.mastersInRoom, id: \.self) { master in
                        NavigationLink(destination: User_MasterDetailse(masterModel: master).navigationBarBackButtonHidden(true)) {
                            
                            User_MasterInToRoomCell(masterModel: master)
                        }
                    }
                }.padding(.top, 26)

            }.createBackgrounfFon()
            .scrollIndicators(.hidden)
        }
    }
}
