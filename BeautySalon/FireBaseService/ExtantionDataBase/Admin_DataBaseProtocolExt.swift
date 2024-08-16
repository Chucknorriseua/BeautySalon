//
//  DataBaseExtProtocol.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 14/10/2024.
//

import Foundation
import FirebaseFirestore

extension Admin_DataBase: Admin_DataBaseDocumentConvert {
    func convertDocumentToClient(_ document: DocumentSnapshot) throws -> Client {
        let data = document.data()
        guard let id = data?["id"] as? String,
              let clientID = data?["clientID"] as? String,
              let name =  data?["name"] as? String,
              let email = data?["email"] as? String,
              let phone = data?["phone"] as? String,
              let date = data?["date"] as? Timestamp else { throw NSError(domain: "Not correct create data", code: 0, userInfo: nil)  }
              let createTampDate = date.dateValue()
        
        return Client(id: id, clientID: clientID, name: name, email: email, phone: phone, date: createTampDate)
    }
    
     func convertDocumentToMater(_ document: DocumentSnapshot) throws -> MasterModel {
        let data = document.data()
        guard let id = data?["id"] as? String,
              let masterID = data?["masterID"] as? String,
              let name = data?["name"] as? String,
              let desc = data?["description"] as? String,
              let email = data?["email"] as? String,
              let phone = data?["phone"] as? String,
              let image = data?["image"] as? String else {
            throw NSError(domain: "snapShot error data", code: 0, userInfo: nil)
        }
        return MasterModel(id: id, masterID: masterID, name: name, email: email,
                           phone: phone, description: desc, image: image, imagesUrl: [])
    }
    
     func convertDocumentToShedule(_ document: DocumentSnapshot) throws -> Shedule {
        let data = document.data()
        guard let id = data?["id"] as? String,
              let masterId = data?["masterId"] as? String,
              let taskTitle =  data?["taskTitle"] as? String,
              let taskService = data?["taskService"] as? String,
              let creationDate = data?["creationDate"] as? Timestamp,
              let tint = data?["tint"] as? String,
              let timesTamp = data?["timesTamp"] as? Timestamp else { throw NSError(domain: "Not correct create data", code: 0, userInfo: nil)  }
        let createTampDate = creationDate.dateValue()
        return Shedule(id: id, masterId: masterId, taskTitle: taskTitle,
                      taskService: taskService, creationDate: createTampDate,
                      tint: tint, timesTamp: timesTamp)
    }
    
     func convertDocumentToCompany(_ document: DocumentSnapshot) throws -> Company_Model {
        let data = document.data()
        guard let id = data?["id"] as? String,
              let adminID = data?["adminID"] as? String,
              let name = data?["name"] as? String,
              let companyName = data?["companyName"] as? String,
              let email = data?["email"] as? String,
              let phone = data?["phone"] as? String,
              let image = data?["image"] as? String,
              let adress = data?["adress"] as? String,
              let desc = data?["description"] as? String,
              let roomPassword = data?["roomPassword"] as? String else {
            throw NSError(domain: "snapShot error data", code: 0, userInfo: nil)
        }
        return Company_Model(id: id, adminID: adminID, name: name,
                             companyName: companyName,
                             adress: adress, email: email,
                             phone: phone, description: desc,
                             roomPassword: roomPassword, image: image)
    }
}
