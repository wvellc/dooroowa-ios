//
//  NotificationModel.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/23/23.
//

import Foundation

// MARK: - NotificationModel
struct NotificationModel: Codable {
    var id: Int?
    var title, messgae, date: String?

    enum CodingKeys: String, CodingKey {
        case id, title, messgae
        case date = "updated_date"
    }
    
    static func fetchNotifications(completion: @escaping (Result<[NotificationModel]?,Error>)->()) {
        var arrNotificaions = [NotificationModel]()
        for index in 1...10 {
            let model = NotificationModel(id: index, title: "Detox the mind", messgae: "Sed ipsum ipsum, ullamcorper tincidunt ligula et, dapibus tristique dui.")
            arrNotificaions.append(model)
        }
        completion(.success(arrNotificaions))
    }
    
    static func clearAllNotifications(completion: @escaping (Result<[NotificationModel]?,Error>)->()) {
        completion(.success([]))
    }
    
    func deleteNotification(completion: @escaping (Result<NotificationModel?,Error>)->()) {
        completion(.success(self))
    }
}
