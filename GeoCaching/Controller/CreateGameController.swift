//
//  CreateGameController.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 17.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import CoreLocation

protocol CreateGameControllerDelegate {
    func canCreateGame(canCreate: Bool)
    func createGame(progress: Float)
    func gameInfoDidChange(duration: Double, length: Double)
}


struct CreateGameController {
    private(set) var canCreateGame: Bool = false {
        didSet {
            delegate?.canCreateGame(canCreate: canCreateGame)
        }
    }
    var game: Game
    
    var waypoints: [CLLocationCoordinate2D] {
        return game.quests.compactMap { $0.locationPolygonPoints.first }
    }
    
    var delegate: CreateGameControllerDelegate?
    
    
    init(questionType: QuestionType) {
        game = Game(name: "", shortDescription: "", longDescription: "", categories: [],
                    duration: 0.0, length: 0.0, image: nil, rating: 0, quests: [])
    }
    
    
    // Quest - Setters
    
    mutating func set(name: String) {
        game.name = name
        checkGameConditions()
        updateProgress()
    }
    
    mutating func set(shortDescription: String) {
        game.shortDescription = shortDescription
        checkGameConditions()
        updateProgress()
    }
    
    mutating func set(longDescription: String) {
        game.longDescription = longDescription
        checkGameConditions()
        updateProgress()
    }
    
    mutating func set(categories: [QuestCategory]) {
        game.categories = categories
        checkGameConditions()
        updateProgress()
    }
    
    mutating func set(image: UIImage) {
        game.image = image
        checkGameConditions()
        updateProgress()
    }
    
    mutating func append(newQuest: Quest) {
        game.quests.append(newQuest)
        checkGameConditions()
        updateProgress()
    }
    
    mutating func update(quest: Quest, atIndex index: Int) {
        game.quests[index] = quest
        checkGameConditions()
        updateProgress()
    }
    
    mutating func set(duration: Double) {
        game.duration = duration
        checkGameConditions()
        updateProgress()
    }
    
    mutating func set(length: Double) {
        game.length = length
        checkGameConditions()
        updateProgress()
    }
    
    
    // MARK: - Quest Condition
    
    private mutating func checkGameConditions() {
        if checkGameName() && checkGameShortDescription() && checkGameLongDescription() && checkGameCategories() && checkGameImage() && checkGameQuests() && checkGameInformation() {
            canCreateGame = true
        } else {
            if !canCreateGame {
                canCreateGame = false
            }
        }
    }
    
    private func checkGameName() -> Bool {
        return !game.name.isEmpty
    }
    
    private func checkGameShortDescription() -> Bool {
        return !game.shortDescription.isEmpty
    }
    
    private func checkGameLongDescription() -> Bool {
        return !game.longDescription.isEmpty
    }
    
    private func checkGameCategories() -> Bool {
        return !game.categories.isEmpty
    }
    
    private func checkGameImage() -> Bool {
        return game.image != nil
    }
    
    private func checkGameQuests() -> Bool {
        return !game.quests.isEmpty
    }
    
    private func checkGameInformation() -> Bool {
        return game.duration > 0 && game.length > 0
    }
    
    
    private func updateProgress() {
        let progress = currentProgress()
        delegate?.createGame(progress: progress)
    }
    
    func currentProgress() -> Float {
        let numberOfSteps: Float = 7
        var numberOfDoneSteps: Float = 0
        
        if checkGameName() { numberOfDoneSteps += 1 }
        if checkGameShortDescription() { numberOfDoneSteps += 1 }
        if checkGameLongDescription() { numberOfDoneSteps += 1 }
        if checkGameCategories() { numberOfDoneSteps += 1 }
        if checkGameImage() { numberOfDoneSteps += 1 }
        if checkGameQuests() { numberOfDoneSteps += 1 }
        if checkGameInformation() { numberOfDoneSteps += 1 }
        
        return numberOfDoneSteps / numberOfSteps
    }
    
}







