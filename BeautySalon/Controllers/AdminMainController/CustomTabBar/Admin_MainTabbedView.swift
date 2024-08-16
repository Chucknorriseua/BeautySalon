//
//  MainTabbedView.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 19/08/2024.
//

import SwiftUI
enum TabbedItems: Int, CaseIterable{
    case home = 0
    case client
    case info
    case settingProf
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .client:
            return "Masters"
        case .info:
            return "Client"
        case .settingProf:
            return "Settings"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "house.circle.fill"
        case .client:
            return "person.2.circle.fill"
        case .info:
            return  "person.circle.fill"
        case .settingProf:
            return "gear"
        }
    }
}

struct Admin_MainTabbedView: View {
    
    @State var selectedTab = 0
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            TabView(selection: $selectedTab) {
                
                AdminMainController().toolbarBackground(.hidden, for: .tabBar)
                    .tag(0)

                GetAllMastersInCompany().toolbarBackground(.hidden, for: .tabBar)
                    .tag(1)

                GetAllUsersOfCompany().toolbarBackground(.hidden, for: .tabBar)
                    .tag(2)

                SettingsView()
                    .tag(3)
            }
            ZStack {
                HStack{
                    ForEach((TabbedItems.allCases), id: \.self){ item in
                        Button{
                            selectedTab = item.rawValue
                        } label: {
                            CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                        }
                    }
                }
                .padding(6)
            }
            .frame(height: 70)
            .background(.ultraThinMaterial)
            .cornerRadius(35)
            .padding(.horizontal, 26)
        }
    }
}

extension Admin_MainTabbedView{
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        HStack(spacing: 10){
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
            if isActive{
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? .black : .gray)
            }
            Spacer()
        }
        .frame(width: isActive ? 140 : 60, height: 60)
        .background(isActive ? .white.opacity(0.9) : .clear)
        .cornerRadius(30)
    }
}

#Preview {
    Admin_MainTabbedView()
}
