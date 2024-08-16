//
//  CompanyAllCell.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 21/08/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct CompanyAllCell: View {
    
    @State var companyModel: Company_Model
    
    var body: some View {
        
        VStack {
            VStack(spacing: 0) {
                if let image = companyModel.image, let url = URL(string: image) {
                    WebImage(url: url)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 380, height: 260)
                        .clipShape(.rect(topLeadingRadius: 10, topTrailingRadius: 120))
                } else {
                    Image("ab1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 380, height: 260)
                        .clipShape(.rect(topLeadingRadius: 10, topTrailingRadius: 120))
                }
   
                
                ZStack(alignment: .center) {
                    
                    VStack(alignment: .center, spacing: 10) {
                        //                    Name
                        Text(companyModel.companyName ?? "").font(.system(size: 18).bold())
                        
                            .lineLimit(4)
                        
                        VStack {
                            //                     Description
                            Text("fdfdsfdsfdsfds fdfdsfdsfdsfds fdfdsfdsfdsfds fdfdsfdsfdsfds fdfdsfdsfdsfds fdfdsfdsfdsfds fdfdsfdsfdsfds  fdfdsfdsfdsfds fdfdsfdsfdsfds dfdsfdsfdsfds fdfdsfdsfdsfds fdfdsfdsfdsfds fdfdsfdsfdsfds fdfdsfdsfdsfds fdfdsfdsfdsfds fdfdsfdsfdsfds fdfdsfdsfdsfds fdfdsfdsfdsfds dsfdsff fdsfds dsdsds")
                                .fontWeight(.medium)
                                .lineLimit(20)
                            
                        }.frame(width: 360, height: 140)
                        //                Email and phone
                        VStack(alignment: .center, spacing: 5) {
                            Text(companyModel.email ?? "")
                            Text(companyModel.phone ?? "")
                        }
                    }
                    
                }
                .frame(width: 380, height: 280)
                .background(.ultraThinMaterial.opacity(0.9), in: .rect(bottomLeadingRadius: 10, bottomTrailingRadius: 120))
                
            }
            
        }.foregroundStyle(Color.white)
    }
}

#Preview(body: {
    CompanyAllCell(companyModel: Company_Model(id: "", name: "", companyName: "", email: "", phone: "", image: ""))
})
