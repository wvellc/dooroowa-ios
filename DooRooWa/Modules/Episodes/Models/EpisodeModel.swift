//
//  EpisodeModel.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/3/23.
//

import Foundation

// MARK: - EpisodeModel
struct EpisodeModel: Decodable {
    var id, weekId: Int?
    var title, description, type, week, color, image: String?

    enum CodingKeys: String, CodingKey {
        case id, title, description, type, week, color, image
        case weekId = "week_id"
    }
}
