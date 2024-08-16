//
//  Auth_Master_ViewModel.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 29/08/2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage

class Auth_Master_ViewModel: ObservableObject {
    
    static var shared = Auth_Master_ViewModel()
    @Published var signInViewmodel = SignInViewModel()
    @Published var selectedImage: Data? = nil
    
    var auth = Auth.auth()
    
    var storage_REF = Storage.storage().reference()
    
    var currentUser: User? {
        return auth.currentUser
    }
    
    
    init(){}
    
// MARK: Func Auth for Master
    
    func createAccount_Master(email: String,
                       password: String,
                       name: String,
                       phone: String) async throws {
        
        do {
            
            
            let result = try await auth.createUser(withEmail: email, password: password)
            
            var dowloadURL: URL? = nil
            
            if let imageData = selectedImage,
               let imageSize = UIImage(data: imageData)?.jpegData(compressionQuality: 0.7) {
                
                let storage = storage_REF.child("/masterImage/\(result.user.uid)")
                _ = try await storage.putDataAsync(imageSize)
                dowloadURL = try await storage.downloadURL()
                
                
            } else { print("DEBUG: ERROR SAVE IMAGE STORAGE") }
            
            let master = MasterModel(id: result.user.uid,
                                     name: name,
                                     email: email,
                                     phone: phone,
                                     image: dowloadURL?.absoluteString ?? "",
                                     images: [])
            
            try await DataBase_FireBase.shared.setData_For_Master_FB(master: master)
            
        } catch {
            
            print("DEBUG: MASTER Error Create master account", error.localizedDescription)
        }
    }
    
    func signIn(email: String, password: String) async throws -> Bool {
        
        do {
            try await auth.signIn(withEmail: email, password: password)
          let com = try await DataBase_FireBase.shared.fetchAllCompany()
            print(com)
            return true
        } catch {
            print("DEBUG: SING IN ERROR sign in Account", error.localizedDescription)
            return false
        }
    }
    
    func signOut() async {
        do {
          try auth.signOut()
            
        } catch {
            print("DEBUG: SignOut", error.localizedDescription)
        }
    }
    
    func saveAccount_Master() async {
        
        
        do {
            try await createAccount_Master(email: signInViewmodel.email,
                                           password: signInViewmodel.password,
                                           name: signInViewmodel.fullName,
                                           phone: signInViewmodel.phone)
            
        } catch {
            print("DEBUG SAVE MASTER: Error save master account", error.localizedDescription)
        }
    }
    
}
