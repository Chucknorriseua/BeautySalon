//
//  Informations.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 19/08/2024.
//

import SwiftUI

struct GetAllUsersOfCompany: View {
    
    @State var userModel: [User] = [.init(id: 0, name: "Anna Woof", email: "qwe@gmail.com", phone: "095345687", date: Date()),
                                     .init(id: 0, name: "Patrick Rassel", email: "patrick@gmail.com", phone: "0953432", date: Date()),
                                     .init(id: 0, name: "Jack Sparrow", email: "jack@gmail.com", phone: "09570987", date: Date()),
                                     .init(id: 0, name: "Natasha Petrovna", email: "natasha@gmail.com", phone: "0935654654", date: Date())]
    
// MARK: Fetch all User Of Company
    var body: some View {
        NavigationView(content: {
           
            VStack {
                Text("Clients for recording")
                    .font(.system(.title, design: .serif, weight: .regular))
                    .foregroundStyle(Color.yellow)
                
                ScrollView {
                     VStack {
                        ForEach(userModel, id:\.self) { user in
                            CellUser()
                        }
                        
                    }
                    
                }.scrollIndicators(.hidden)
            }
            .createFrame()
        })
    }
}

#Preview {
    GetAllUsersOfCompany()
}
