//
//  NotificationModel.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/23/23.
//

import Foundation

// MARK: - NotificationModel
struct NotificationModel: Decodable {
    var id: Int?
    var title, messgae, date: String?

    enum CodingKeys: String, CodingKey {
        case id, title, messgae
        case date = "updated_date"
    }
}
