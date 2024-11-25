//
//  TabBarButtonBack.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 15/10/2024.
//

import SwiftUI

struct TabBarButtonBack: View {
    
    let action: () -> ()
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack(spacing: -8) {
                Image(systemName: "arrow.left.to.line.compact")
                    .font(.system(size: 16))
                Text("Back")
                
            }.foregroundStyle(Color.white)
                .padding(.all, 4)
                .background(Color.white.opacity(0.4), in: .rect(cornerRadius: 24))
        })
    }
}
