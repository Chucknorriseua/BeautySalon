//
//  AuthFbHowAdminViewModel.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 25/08/2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage

protocol isFormValid {
    var isFarmValid: Bool { get }
}

class Auth_ADMIN_Viewmodel: ObservableObject {
    
    static var shared = Auth_ADMIN_Viewmodel()
    
    @Published var signInViewModel = SignInViewModel()
    @Published var selectedImage: Data? = nil
    
    let auth = Auth.auth()
    var currentUser: User? {
        return auth.currentUser
    }
    
    init() {

    }
    
    func creatAccount(email: String,
                      password: String,
                      nameAdmin: String,
                      nameCompany:String,
                      phone: String) async throws {
        
        do {
            
            let result = try await auth.createUser(withEmail: email,
                                                   password: password)
            var dowloadURL: URL? = nil
            
            if let imageData = selectedImage,
            let uiImagedata = UIImage(data: imageData)?.jpegData(compressionQuality: 0.7) {
            let storage = Storage.storage().reference().child("/image/\(result.user.uid)")
            _ = try await storage.putDataAsync(uiImagedata)
            dowloadURL = try await storage.downloadURL()
                
            } else { print("DEBUG: Error download image...") }
            
            
            let admin = Company_Model(id: result.user.uid,
                                   name: nameAdmin,
                                   companyName: nameCompany,
                                    adress: "",
                                   email: email,
                                   phone: phone,
                                   description: "",
                                   image: dowloadURL?.absoluteString ?? "")
            
            try await DataBase_FireBase.shared.setCompanyForAdmin(admin: admin)
            
        } catch { print("Error create account with Fb", error.localizedDescription.lowercased()) }
    }
    
    func saveAdminCompany() async  {
        
        do {
            
            try await creatAccount(email: signInViewModel.email,
                                   password: signInViewModel.password,
                                   nameAdmin: signInViewModel.fullName,
                                   nameCompany: signInViewModel.nameCompany
                                   ,phone: signInViewModel.phone)
            
        } catch {
            print("Error saveAdminCompany", error.localizedDescription)
        }
        
    }
    
    func signIn(email: String, password: String) async -> Bool {
        do {
            try await Auth.auth().signIn(withEmail: email,
                                         password: password)
            return true
        } catch {
            print("Errorororor", error.localizedDescription)
            return false
        }
    }
    
    
    
    func signOut() {
        
        do {
            try Auth.auth().signOut()
            print("signOut Succec")
        } catch {
            print("DEBUG: SignOut Error...", error.localizedDescription)
        }
    }
    
    func createMasterAccount() {
        
    }
    
    func createUser() {
        
    }
    
}
