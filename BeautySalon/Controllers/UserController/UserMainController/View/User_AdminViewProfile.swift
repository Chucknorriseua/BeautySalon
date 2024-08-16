//
//  User_AdminViewInfo.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 04/10/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct User_AdminViewProfile: View {
    
    @State var adminProfile: Company_Model
    
    var body: some View {
        GeometryReader { geo in
            
            VStack(spacing: -22) {
                HStack(spacing: 0) {
                    
                    if let url = URL(string: adminProfile.image ?? "" ) {
                        
                        WebImage(url: url)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geo.size.width * 0.3,
                                   height: geo.size.height * 0.6)
                            .clipShape(Circle())
                        
                    } else {
                        Image("ab3")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geo.size.width * 0.3,
                                   height: geo.size.height * 0.6)
                            .clipShape(Circle())
                    }
                    
                    Text("Hello, World!")
                        .font(.system(size: 24, weight: .bold))
    
                    Spacer()
                    NavigationLink(destination: UserSheduleForAdmin()) {
                        Image(systemName: "newspaper.circle")
                            .font(.system(size: 42, weight: .bold))
                            .padding(.trailing, 15)
                            .padding(.top, 40)
                    }
                }
                Text("Administrator")
                    .font(.system(size: 14, weight: .medium).smallCaps())
                
            }.frame(width: geo.size.width * 1, height: geo.size.height * 0.8)
                .foregroundStyle(Color.yellow.opacity(0.8))
                .background(Color.clear)
            
        }.frame(height: 140)
            .padding(.bottom, 8)
    }
}

#Preview {
    User_AdminViewProfile()
}
