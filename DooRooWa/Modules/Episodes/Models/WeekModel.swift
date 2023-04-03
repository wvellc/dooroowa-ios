//
//  WeekModel.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/30/23.
//

import Foundation

// MARK: - WeekModel
struct WeekModel: Decodable {
    var id: Int?
    var week, color, image: String?

    enum CodingKeys: String, CodingKey {
        case id, week, color, image
    }
}
