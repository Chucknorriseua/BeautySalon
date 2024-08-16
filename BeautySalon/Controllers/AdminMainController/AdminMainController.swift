//
//  AdminAllMaster.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 19/08/2024.
//

import SwiftUI

struct AdminMainController: View {
    
    var body: some View {
        
        NavigationView(content: {
            HStack(spacing: 280) {
                NavigationLink(destination: AddNewMaster()) {
                        
                    Image(systemName: "person.crop.circle.fill.badge.plus")
                        .font(.system(size: 34))
                    .foregroundStyle(Color.white) }.frame(maxHeight: .infinity, alignment: .topLeading)
                
                
                NavigationLink(destination: AdminListNews()) {
                        
                    Image(systemName: "list.bullet.circle.fill")
                        .font(.system(size: 34))
                        .foregroundStyle(Color.white)}.frame(maxHeight: .infinity, alignment: .topTrailing)
            }
            .createFrame()
        })
    }
}

#Preview {
    AdminMainController()
}
