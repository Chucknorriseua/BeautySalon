//
//  SignInViewModel.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 17/08/2024.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var nameCompany: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var showPassword: Bool = false
    @Published var fullName: String = ""
    @Published var phone: String = ""
    @Published var city: String = ""
    @Published  var isAnimation: Bool = false


}
