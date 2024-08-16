//
//  KeyBoardProvide.swift
//  BeautyMasters
//
//  Created by Евгений Полтавец on 15/09/2024.
//

import SwiftUI
import Combine

class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0
    
    var _center: NotificationCenter
    
    init(center: NotificationCenter = .default) {
        _center = center
        _center.addObserver(self,
                            selector: #selector(keyboardWillShow(notification:)),
                            name: UIResponder.keyboardWillShowNotification,
                            object: nil)
        _center.addObserver(self,
                            selector: #selector(keyboardWillHide(notification:)),
                            name: UIResponder.keyboardWillHideNotification,
                            object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            withAnimation {
                currentHeight = keyboardFrame.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        withAnimation {
            currentHeight = 0
        }
    }
    
    deinit {
        _center.removeObserver(self)
    }
}
