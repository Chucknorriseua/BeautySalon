//
//  CellUser.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 21/08/2024.
//

import SwiftUI

struct CellUser: View {
    
    
    
    var body: some View {
        
        VStack(alignment: .center) {
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Anna Woodman")
                    Text("phone:  345-345-657")
                    Text("email:  anna34@gmail.com")
                    
                }.frame(width: 280, alignment: .leading)
                .foregroundStyle(Color.white)
                .font(.system(size: 22, weight: .bold))
                
                Image("ab3")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 90, height: 90)
                    .clipShape(.rect(cornerRadius: 12))
                    .padding(.bottom, 60)

            }
            
        }.frame(width: 380, height: 160)
            .background(.ultraThinMaterial.opacity(0.7), in: .rect(topLeadingRadius: 44, bottomTrailingRadius: 76))
            .overlay(alignment: .bottom) {
            
                    Text("__")
                        .foregroundStyle(Color.white)
                        .font(.title.bold())
                
            }
    }
}

#Preview {
    CellUser()
}
