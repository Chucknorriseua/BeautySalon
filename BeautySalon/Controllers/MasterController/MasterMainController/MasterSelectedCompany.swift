//
//  MasterSelectedCompany.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 22/08/2024.
//

import SwiftUI

struct MasterSelectedCompany: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView(content: {
            
            VStack {
                
                Text("Сhoose Salon")
                    .font(.system(.title, design: .serif, weight: .regular))
                    .foregroundStyle(Color.yellow)
                
                ScrollView {
                    NavigationLink(destination: MasterTabBar().navigationBarBackButtonHidden(true)) {
                        VStack {
                            ForEach(0..<10, id:\.self) { company in
                                
                                CompanyAllCell()
                                
                            }
                        }
                    }
                }.scrollIndicators(.hidden)
                
            }.overlay(alignment: .topLeading, content: {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.uturn.backward.circle.fill")
                     .foregroundStyle(Color.white)
                     .font(.system(size: 28))
                })
            })
            .createFrame()
        })
    }
}

#Preview {
    MasterSelectedCompany()
}
