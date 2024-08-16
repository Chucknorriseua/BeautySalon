//
//  NotificationController.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 10/10/2024.
//

import SwiftUI
import UserNotifications
@available(iOS 16.0, *)
class NotificationController: NotificationCenter {
    
    static var sharet = NotificationController()
    var notificationCenter = UNUserNotificationCenter.current()

    func notify(title: String, subTitle: String, timeInterval: Int) {
        print("Notify called with title: \(title) and subtitle: \(subTitle)")
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subTitle
        content.sound = UNNotificationSound.default
        content.badge = 1
        
//        guard let path = Bundle.main.path(forResource: "user", ofType: "png") else {
//            print("Image not found")
//            return
//        }
//        
//        let url = URL(fileURLWithPath: path)
//
//        do {
//            let attachment = try UNNotificationAttachment(identifier: "ab3", url: url)
//            content.attachments = [attachment]
//        } catch {
//            print("Error load image from bundle: ", error.localizedDescription)
//        }

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInterval), repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            } else {
                print("Notification added successfully!")
            }
        }
    }
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    print("Permission granted for notifications.")
                    UIApplication.shared.registerForRemoteNotifications()
                    self.getNotificationsSetting()
                } else {
                    print("Permission for push notifications denied.")
                }
            }
        }
    }
    
    func getNotificationsSetting() {
        notificationCenter.getNotificationSettings { settings in
            print("Notifications settings: \(settings)")
            if settings.authorizationStatus == .authorized {
                print("Notifications are authorized.")
            } else {
                print("Notifications are not authorized.")
            }
        }
    }
}
