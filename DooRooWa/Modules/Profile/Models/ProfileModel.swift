//
//  ProfileModel.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/4/23.
//

import Foundation

// MARK: - ProfileModel
struct ProfileModel: Codable {
    var title, placeholder, key : String?

    enum CodingKeys: String, CodingKey {
        case title, placeholder, key
    }
}
