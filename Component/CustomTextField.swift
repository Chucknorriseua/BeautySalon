//
//  CustomTextField.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 17/08/2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct CustomTextField: View {
    
    var text: Binding<String>
    var title: String
    var width: CGFloat
    
    
    @Binding var showPassword: Bool
    
    var body: some View {
        Group {
            if title == "Password" && !showPassword {
                SecureField(text: text) {
                    Text(title)
                        .foregroundStyle(.white.opacity(0.5))
                        .fontWeight(.semibold)
                }
            } else {
                TextField(text: text) {
                    Text(title)
                        .foregroundStyle(.white.opacity(0.5))
                        .fontWeight(.semibold)
                }
            }
        }
        .foregroundStyle(.white)
        .padding(.leading)
        .frame(width: UIScreen.main.bounds.width - 20, height: 50)
        .background(Color(hex: "#21292F"), in: RoundedRectangle(cornerRadius: 10))
        .overlay(alignment: .trailing) {
            if title == "Password" {
                Button(action: {
                    withAnimation {
                        showPassword.toggle()
                    }
                }, label: {
                    Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                        .foregroundStyle(Color(hex: "F3E3CE"))
                        .padding(.trailing)
                })
            }
        }
    }
}
@available(iOS 16.0, *)
#Preview {
    CustomTextField(text: .constant(""), title: "Password", width: UIScreen.main.bounds.width - 30, showPassword: .constant(false))
    
}
