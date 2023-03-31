//
//  NotificationsVM.swift
//  DooRooWa
//
//  Created by Vision on 31/03/23.
//

import Foundation

class NotificationsVM: NSObject {
    
    //MARK: - Variables
        
    override init() {
        super.init()
        /* Initial setup when view load */
        doInitialSettings()
    }
    
    deinit {
        print("Notifications View Model released from memory")
    }

    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {

    }
    
    func fetchNotifications(completion: @escaping ([NotificationModel])->()) {
        var arrNotificaions = [NotificationModel]()
        for index in 1...10 {
            let model = NotificationModel(id: index, title: "Detox the mind", messgae: "Sed ipsum ipsum, ullamcorper tincidunt ligula et, dapibus tristique dui.")
            arrNotificaions.append(model)
        }
        completion(arrNotificaions)
    }
    
    func clearAllNotifications(completion: @escaping ([NotificationModel])->()) {
        completion([])
    }
    
    func delete(notification: NotificationModel?, at index: Int, completion: @escaping (NotificationModel?)->()) {
        completion(notification)
    }
}
