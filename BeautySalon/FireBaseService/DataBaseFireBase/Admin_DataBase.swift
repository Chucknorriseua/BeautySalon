//
//  DataBaseFireBase.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 25/08/2024.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage


@MainActor
class Admin_DataBase {
    
//MARK: Properties
    
    static var shared = Admin_DataBase()
    
    weak var listener: ListenerRegistration?
    
    let auth = Auth.auth()
    
    init() {
        
    }
    
    private let db = Firestore.firestore()
    
    private let storage = Storage.storage().reference()
    
    private var mainFS: CollectionReference {
        return db.collection("BeautySalon")
    }
    
    private var masterFs: CollectionReference {
        return db.collection("Master")
    }
    
    private var userFS: CollectionReference {
        return db.collection("User")
    }
    
    
    
    // MARK:  /\_____________________________ADMIN___________________________________/\
    
    //    MARK: Save company on Fire Base BeautySalon/Company.... name admin and company
    func setCompanyForAdmin(admin: Company_Model) async throws {
        guard let uid = auth.currentUser?.uid else { return }
        
        try await mainFS.document(uid).setData(admin.admin_Model_FB, merge: true)
    }
    
    
// Send shedule for master about client
    func send_ShedulesTo_Master(idMaster: String, shedule: Shedule) async throws {
       
        do {
            try await masterFs.document(idMaster).collection("Shedule").addDocument(data: shedule.shedule)
            
        } catch {
            print("DEBUG: sendAppoitmentToMaster not correct send...", error.localizedDescription)
            throw error
        }
    }
    
    // add a master to your room
        func add_MasterToRoom(idMaster: String, master: MasterModel) async throws {
           
            do {
                try await mainFS.document(idMaster).collection("Masters").document(master.id).setData(master.master_ModelFB)
            } catch {
                print("DEBUG: sendAppoitmentToMaster not correct send...", error.localizedDescription)
                throw error
            }
        }
    
    func isMasterAllReadyInRoom(masterId: String) async -> Bool {
        let ref = mainFS.document(masterId).collection("Masters").document(masterId)
        do {
            let document = try await ref.getDocument()
            return document.exists
        } catch {
            print("DEBUG: Error isMasterAllReadyInRoom", error.localizedDescription)
            return false
        }
    }
  
//  Fetch profile as Admin
    func fetchAdmiProfile() async throws -> Company_Model {
        
        guard let uid = auth.currentUser?.uid else { throw NSError(domain: "Not found id", code: 0, userInfo: nil) }
        
        do {
            let snapShot = try await mainFS.document(uid).getDocument()
            guard let data = snapShot.data(),
                  let adminID = data["adminID"] as? String,
                  let id = data["id"] as? String,
                  let name = data["name"] as? String,
                  let companyName = data["companyName"] as? String,
                  let email = data["email"] as? String,
                  let phone = data["phone"] as? String,
                  let image = data["image"] as? String,
                  let adress = data["adress"] as? String,
                  let desc = data["description"] as? String else {
                throw NSError(domain: "Not found id", code: 0, userInfo: nil)
            }
            return Company_Model(id: id, adminID: adminID, name: name, companyName: companyName, adress: adress, email: email, phone: phone, description: desc, image: image)

        } catch {
            print("DEBUG: Error fetch profile as admin...", error.localizedDescription)
            throw error
        }
        
    }
    
    //  MARK: Fetch all comapny with Fire Base BeautySalon/Company.... name admin and company
    func fetchAllCompany() async throws -> [Company_Model] {
        
        do {
            let snapShot = try await mainFS.getDocuments()
            
            let companies: [Company_Model] = try snapShot.documents.compactMap { document in
                let data = document.data()
                
                guard let id = data["id"] as? String,
                      let adminID = data["adminID"] as? String,
                      let name = data["name"] as? String,
                      let companyName = data["companyName"] as? String,
                      let email = data["email"] as? String,
                      let phone = data["phone"] as? String,
                      let image = data["image"] as? String,
                      let adress = data["adress"] as? String,
                      let desc = data["description"] as? String else {
                    throw NSError(domain: "snapShot error data", code: 0, userInfo: nil)
                }
                
                return Company_Model(id: id, adminID: adminID, name: name, companyName: companyName, adress: adress, email: email, phone: phone, description: desc, image: image)
            }
            
            print("COMPANIES: \(companies), SNAPSHOT: \(snapShot)")
            return companies
            
        } catch {
            print("DEBUG: Error fetch all company", error.localizedDescription)
            throw error
        }
    }
//  fetch All Masters in current company
    func fetch_All_Masters() async throws -> [MasterModel] {
        do {
            
           let snapShot = try await masterFs.getDocuments()
            let masters: [MasterModel] = try snapShot.documents.compactMap { document in
                let data = document.data()
                
                guard let id = data["id"] as? String,
                      let masterID = data["masterID"] as? String,
                      let name = data["name"] as? String,
                      let desc = data["description"] as? String,
                      let email = data["email"] as? String,
                      let phone = data["phone"] as? String,
                      let image = data["image"] as? String else {
                    throw NSError(domain: "snapShot error data", code: 0, userInfo: nil)
                }
                return MasterModel(id: id, masterID: masterID, name: name, email: email, phone: phone, description: desc, image: image, imagesUrl: [])
            }
            return masters
        } catch {
            print("DEBUG ERROR FETCH ALL MASTER...", error.localizedDescription)
            throw error
        }
        
    }
    
// update profile as admin

    func updateProfile_Admin() async {
        guard let uid = auth.currentUser?.uid else { return }
        
        listener = mainFS.document(uid).addSnapshotListener({ snap, error in
            
            if let error = error {
                print("Error", error.localizedDescription)
            }
            
            guard let document = snap, document.exists else { return }
            
            if let data = try? document.data(as: Company_Model.self) {
                
                DispatchQueue.main.async {
                    AdminViewModel.shared.adminProfile = data
                }
            }
        })
    }
    
    
    func upDatedImage_URL_Firebase_Admin(imageData: Data) async -> URL? {
        guard let uid = auth.currentUser?.uid else { return nil }
        
        guard let imageData = UIImage(data: imageData) else { return nil}
        guard let image = imageData.jpegData(compressionQuality: 0.5) else { return nil}
        do {
            let store = storage.child("image/\(uid)")
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            
            _ = try await store.putDataAsync(image, metadata: metadata)
            
            let dowload = try await store.downloadURL()
            return dowload
        } catch {
            print("DEBUG: Error upload image...", error.localizedDescription)
            return nil
        }
    }
    
    func uploadImageFireBase_Admin(id: String, url: URL) async {
        do {
            let adminFB = mainFS.document(id)
            try await adminFB.updateData(["image": url.absoluteString])
            
        } catch {
            print("DEBUG: Error uploadImageFireBase", error.localizedDescription)
        }
    }
    
    
    func deinitListener() {
        listener?.remove()
        listener = nil
        print("DE INIT deinitListener---------->>>>>>>>>>>>>>>>>")
    }
    
    deinit {
        Task {
           await deinitListener()
        }
    }
}

