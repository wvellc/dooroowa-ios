//
//  QuestionModel.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/4/23.
//

import Foundation

// MARK: - QuestionModel
struct QuestionModel: Codable {
    var id: Int?
    var question, description, answer: String?

    enum CodingKeys: String, CodingKey {
        case id, question, description, answer
    }
}
