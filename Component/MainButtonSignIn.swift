//
//  MainButtonSignIn.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 22/08/2024.
//

import SwiftUI

struct MainButtonSignIn: View {
    
    let image: String
    let title: String
    let action: () -> ()
    
    var body: some View {
        Button(action: {
            action()
            
        }, label: {
            HStack {
                Image(systemName: image)
                Text(title)
            }   .frame(width: UIScreen.main.bounds.width - 40, height: 30)
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
                .padding()
                .background(Color(red: 0.11, green: 0.14, blue: 0.12))
                .clipShape(.rect(cornerRadius: 24))
                .shadow(color: .black.opacity(0.3), radius: 10, x: 5, y: 8)
                .foregroundStyle(Color.red.opacity(0.8))
                .font(.system(size: 18, weight: .heavy).bold())
        })
        .padding()
    }
}
