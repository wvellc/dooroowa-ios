//
//  UserModel.swift
//  DooRooWa
//
//  Created by Vision on 14/03/23.
//

import Foundation

// MARK: - UserModel
struct UserModel: Codable {
    var id: Int?
    var name, email, deviceToken, password, oldPassword, confrimPassword, phone, deviceType, profilePicture: String?
    var profilePictureData: String?
   
    enum CodingKeys: String, CodingKey {
        case id, name, email, password, phone, oldPassword, confrimPassword
        case deviceToken = "device_token"
        case deviceType = "device_type"
        case profilePicture = "profile_picture"
        case profilePictureData = "profile_picture_data"
    }
}

