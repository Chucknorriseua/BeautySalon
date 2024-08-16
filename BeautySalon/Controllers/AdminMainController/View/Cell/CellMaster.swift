//
//  CellMaster.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 19/08/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct CellMaster: View {
    
    @State var masterAll: MasterModel
    
    var body: some View {
        
        VStack(alignment: .center) {
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(masterAll.name)
                    Text("phone:  \(masterAll.phone)")
                    Text("email:  \(masterAll.email)")
                    
                }.frame(width: 280, alignment: .leading)
                .foregroundStyle(Color.white)
                .font(.system(size: 22, weight: .bold))
                
                if let url = URL(string: masterAll.image) {
                    
                 WebImage(url: url)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 90, height: 90)
                        .clipShape(.rect(cornerRadius: 12))
                        .padding(.bottom, 60)
                    
                } else {
                    Image("ab3")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 90, height: 90)
                        .clipShape(.rect(cornerRadius: 12))
                        .padding(.bottom, 60)
                }

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
    CellMaster(masterAll: MasterModel(id: "", name: "", email: "", phone: "", image: ""))
}
