//
//  ClientViewModel.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 03/10/2024.
//

import SwiftUI
import FirebaseFirestore

final class ClientViewModel: ObservableObject {
    
    static let shared = ClientViewModel()
    
    
    @Published private(set) var comapny: [Company_Model] = []
    @Published private(set) var mastersInRoom: [MasterModel] = []
    
    
    @Published var adminProfile: Company_Model
    @Published var clientModel: Client
    
    @Published var currentDate: Date = Date()
    
    private init(adminProfile: Company_Model? = nil, clientModel: Client? = nil) {
        self.adminProfile = adminProfile ?? Company_Model.companyModel()
        self.clientModel = clientModel ?? Client.clientModel()
    }
    
    
    func fetchAll_Comapny() async {
        do {
          let comapnies = try await Master_DataBase.shared.fetchAllCompany()
            await MainActor.run { [weak self] in
                guard let self else { return }
                self.comapny = comapnies
            }
            await fetch_ProfileClient()
        } catch {
            print("DEBUG: ERROR fetch company", error.localizedDescription)
        }
    }
    
   private func fetch_ProfileClient() async {
        do {
            guard let client = try await Client_DataBase.shared.fetchClient_DataFB() else { return }
            await MainActor.run { [weak self] in
                guard let self else { return }
                self.clientModel = client
            }
        } catch {
        print("DEBUG: ERROR fetch current client...", error.localizedDescription)
        }
    }
 
    func fetchCurrent_AdminSalon(adminId: String) async {
        do {
            guard let admin = try await Client_DataBase.shared.fetchAdmiProfile(adminId: adminId) else { return}
            await MainActor.run { [weak self] in
                guard let self else { return }
                self.adminProfile = admin
            }
        } catch {
            print("DEBUG: ERROR fetch current admin salon...", error.localizedDescription)
        }
    }
    
    func fetchAllMasters_FromAdmin() async {
        let adminId = adminProfile.adminID
        do {
            let masters = try await Client_DataBase.shared.getAllMastersFrom_AdminRoom(adminId: adminId)
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.mastersInRoom = masters
            }
        } catch {
            print("DEBUG: ERROR fetch all masters...", error.localizedDescription)
        }
    }
    
    func send_SheduleForAdmin(adminID: String, record: Shedule) async {
        do {
            try await Client_DataBase.shared.send_RecordForAdmin(adminID: adminID, record: record)
            try await Client_DataBase.shared.setData_ClientForAdmin(adminID: adminID, clientModel: clientModel)
        } catch {
            print("DEBUG: ERROR send record admin...", error.localizedDescription)
        }
    }
    
    func save_UserProfile() async {
        let adminID = adminProfile.adminID
        do {
            try await Client_DataBase.shared.setData_ClientFireBase(clientModel: clientModel)
            try await Client_DataBase.shared.setData_ClientForAdmin(adminID: adminID, clientModel: clientModel)
        } catch {
            print("DEBUG: ERROR send record admin...", error.localizedDescription)
        }
    }
}
