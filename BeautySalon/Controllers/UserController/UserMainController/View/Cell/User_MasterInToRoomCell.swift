//
//  User_MasterInToRoomCell.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 04/10/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct User_MasterInToRoomCell: View {
    
    @State var masterModel: MasterModel
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(masterModel.name)
                        .font(.system(size: 24, weight: .heavy))
                        .padding(.leading, 14)
                    
                    HStack {
                        Text("You can also see the works of this master")
                            .font(.system(size: 16, weight: .heavy))
                    }

                }.padding(.leading)
                    .foregroundStyle(Color.white.opacity(0.92))
                    .lineLimit(2)

                if let url = URL(string: masterModel.image ?? "") {
                    
                    WebImage(url: url)
                        .resizable()
                        .indicator(.activity)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width * 0.3,
                               height: geometry.size.height * 0.6)
                        .clipShape(Circle())
                        .padding(.trailing, 4)
                    
                } else {
                    Image("ab3")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width * 0.3,
                               height: geometry.size.height * 0.6)
                        .clipShape(Circle())
                        .padding(.trailing, 4)
                    
                }
            }.frame(width: geometry.size.width * 1, height: geometry.size.height * 0.8)
                .background(Color.init(hex: "#3e5b47").opacity(0.7), in: .rect(cornerRadius: 36))
                .overlay(alignment: .bottom) {
                    VStack {
                        
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.system(size: 24, weight: .heavy))
                            .padding(.leading, 18)
                            .padding(.trailing, 18)
                            .padding(.top, 2)
                            .foregroundStyle(Color.white.opacity(0.92))
                    }.background(Color.gray.opacity(0.4), in: .rect(topLeadingRadius: 35, topTrailingRadius: 35))
                }
        }
        .frame(height: 200)
        .padding(.vertical, -20)
        .padding(.leading, 6)
        .padding(.trailing, 6)
    }
}

//#Preview {
//    User_MasterInToRoomCell(masterModel: ClientViewModel.shared)
//}
