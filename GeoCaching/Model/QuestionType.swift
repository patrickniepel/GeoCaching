//
//  QuestionType.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 06.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

enum QuestionType: Int, Codable {
    case textInput
    case fourChoices
    case date
    case image
    case number
    
    static var allCases: [QuestionType] = [.textInput, .fourChoices, .date, .image, .number]
    
    init?(dbName: String) {
        switch dbName {
        case "textinput": self = .textInput
        case "four_choices": self = .fourChoices
        case "date": self = .date
        case "image": self = .image
        case "number": self = .number
        default: return nil
        }
    }
    
    var name: String {
        switch self {
        case .textInput: return "Textinput"
        case .fourChoices: return "4 Choices"
        case .date: return "Date"
        case .image: return "Image"
        case .number: return "Number"
        }
    }
    
    var dbName: String {
        switch self {
        case .textInput: return "textinput"
        case .fourChoices: return "four_choices"
        case .date: return "date"
        case .image: return "image"
        case .number: return "number"
        }
    }
}
