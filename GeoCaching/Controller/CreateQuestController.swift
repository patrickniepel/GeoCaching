//
//  CreateQuestController.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 16.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import CoreLocation

protocol CreateQuestControllerDelegate {
    func canCreateQuest(canCreate: Bool)
    func createQuest(progress: Float)
}

struct CreateQuestController {
    private(set) var canCreateQuest: Bool = false {
        didSet {
            delegate?.canCreateQuest(canCreate: canCreateQuest)
        }
    }
    var quest: Quest {
        didSet {
            checkQuestConditions()
            updateProgress()
        }
    }
    
    var delegate: CreateQuestControllerDelegate?
    
    
    init() {
        let defaultQuestionType = QuestionType.textInput
        quest = Quest(answers: [], question: "", image: nil,
                      questionType: defaultQuestionType, locationPolygonPoint: nil)
    }
    
    
    // Quest - Setters
    
    mutating func set(answers: [String]) {
        quest.answers = answers
        checkQuestConditions()
        updateProgress()
    }
    
    mutating func set(question: String) {
        quest.question = question
        checkQuestConditions()
        updateProgress()
    }
    
    mutating func set(image: UIImage) {
        quest.image = image
        checkQuestConditions()
        updateProgress()
    }
    
    mutating func set(questionType: QuestionType) {
        quest.questionType = questionType
        checkQuestConditions()
        updateProgress()
    }
    
    mutating func set(locationPolygonPoint: CLLocationCoordinate2D) {
        quest.locationPolygonPoint = locationPolygonPoint
        checkQuestConditions()
        updateProgress()
    }
    
    
    // MARK: - Quest Condition
    
    private mutating func checkQuestConditions() {
        if checkQuestQuestion() && checkQuestAnswers() && checkQuestImage() && checkQuestPolygonPoints() {
            canCreateQuest = true
        } else {
            if !canCreateQuest {
                canCreateQuest = false
            }
        }
    }
    
    private func checkQuestQuestion() -> Bool {
        return !quest.question.isEmpty
    }
    
    private func checkQuestAnswers() -> Bool {
        switch quest.questionType {
        case .fourChoices: return quest.answers.count == 4
        default: return quest.answers.count == 1
        }
    }
    
    private func checkQuestImage() -> Bool {
        return quest.image != nil
    }
    
    private func checkQuestPolygonPoints() -> Bool {
        return quest.locationPolygonPoint != nil
    }
    
    private func updateProgress() {
        let progress = currentProgress()
        delegate?.createQuest(progress: progress)
    }
    
    func currentProgress() -> Float {
        let numberOfSteps: Float = 4
        var numberOfDoneSteps: Float = 0
        
        if checkQuestQuestion() { numberOfDoneSteps += 1 }
        if checkQuestAnswers() { numberOfDoneSteps += 1 }
        if checkQuestImage() { numberOfDoneSteps += 1 }
        if checkQuestPolygonPoints() { numberOfDoneSteps += 1 }
        
        return numberOfDoneSteps / numberOfSteps
    }
    
}







