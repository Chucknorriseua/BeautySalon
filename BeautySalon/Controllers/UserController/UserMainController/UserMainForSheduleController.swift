//
//  ClientMainForSheduleController.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 03/10/2024.
//

import SwiftUI

struct UserMainForSheduleController: View {
    
    //  СЛЕВА КНОПКА ВЫЙТИ С ПРАВА НАСТРОЙКИ ПОМЕНЯТЬ НОМЕР ИМЯ
    //    ЗДЕСЬ ПОЛУЧАЕМ ВСЕХ МАСТЕРОВ ЭТОГО САЛОНА
    //    ПЕРЕХОЖИМ К МАСТЕРУ ЧТОБ ЗАПИСАТСЯ
    //    ГДЕ ПРОСМОТРЕТЬ ПОРТФОЛИО МАСТЕРА?
    
    @EnvironmentObject var coordinator: CoordinatorView
    
    
    var body: some View {
        
        VStack {
            
            Text("Hello, World!")
            
        }.createBackgrounfFon()
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button(action: {
                        coordinator.pop()
                    }, label: {
                        HStack(spacing: -8) {
                            Image(systemName: "arrow.left.to.line.compact")
                                .font(.system(size: 18))
                            Text("Back")
                            
                        }.foregroundStyle(Color.white)
                    })
                }
            })
            .foregroundStyle(Color.white)
            .tint(.yellow)
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button(action: {
                        coordinator.pop()
                    }, label: {
                        HStack(spacing: -8) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 18))
                        }.foregroundStyle(Color.white)
                    })
                }
            })
            .foregroundStyle(Color.white)
            .tint(.yellow)
    }
}

#Preview {
    UserMainForSheduleController()
}
