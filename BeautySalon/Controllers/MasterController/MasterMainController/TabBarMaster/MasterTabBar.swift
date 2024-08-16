//
//  MasterTabBar.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 21/08/2024.
//


import SwiftUI
enum TabbedItemsMaster: Int, CaseIterable{
    case home = 0
    case info
    case settingProf
    
    var title: String{
        switch self {
        case .home:
            return "Home"
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
        case .info:
            return  "person.circle.fill"
        case .settingProf:
            return "gear"
        }
    }
}

struct MasterTabBar: View {
    
    @State var selectedTab = 0
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            TabView(selection: $selectedTab) {
                MasterMainController().toolbar(.hidden, for: .tabBar)
                    .tag(0)

                GetAllUsersOfCompany().toolbar(.hidden, for: .tabBar)
                    .tag(1)

                SettingsView().toolbar(.hidden, for: .tabBar)
                    .tag(2)
            }
            ZStack {
                HStack{
                    ForEach((TabbedItemsMaster.allCases), id: \.self){ item in
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

extension MasterTabBar{
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
        .frame(width: isActive ? 120 : 60, height: 60)
        .background(isActive ? .white.opacity(0.6) : .clear)
        .cornerRadius(30)
    }
}

#Preview {
    MasterTabBar()
}
