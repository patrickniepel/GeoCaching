//
//  Quest.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 25.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseDatabase
import MobileCoreServices

struct Quest {
    
    init(answers: [String], question: String, image: UIImage?, questionType: QuestionType, locationPolygonPoints: [CLLocationCoordinate2D]) {
        self.id = UUID().uuidString
        self.answers = answers
        self.question = question
        self.image = image
        self.questionType = questionType
        self.locationPolygonPoints = locationPolygonPoints
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String:Any],
            let id = snapshot.key as? String,
            let answers = dict["answers"] as? [String],
            let question = dict["question"] as? String,
            let questionTypeDBName = dict["questionType"] as? String,
            let questionType = QuestionType(dbName: questionTypeDBName),
            let locationPolygonPointsString = dict["locationPolygonPoints"] as? [String]
            else {
                return nil
        }
        
        self.id = id
        self.answers = answers
        self.question = question
        self.questionType = questionType
        let locationPolygonPointsArray = locationPolygonPointsString[0].components(separatedBy: ";")
        let locationPolygonPoints = CLLocationCoordinate2D(latitude: Double(locationPolygonPointsArray[0])!, longitude: Double(locationPolygonPointsArray[1])!)
        let locationPolygonPointsArrayToSet = [locationPolygonPoints]
        self.locationPolygonPoints = locationPolygonPointsArrayToSet
    }
    
    var id: String
    var answers: [String]
    var correctAnswer: String {
        return answers.first ?? "Error"
    }
    var question: String
    var image: UIImage?
    var questionType: QuestionType
    var locationPolygonPoints: [CLLocationCoordinate2D]
    var toDictionary: [String:Any] {
        return [
            "answers": answers,
            "question": question,
            "questionType": questionType.dbName,
            "locationPolygonPoints": locationPolygonPoints.map { "\($0.latitude);\($0.latitude)" }
        ]
    }
}


/**
 Diese Klasse wird **ausschließlich** dafür verwendet, um Quest drop und drag bar zu machen. Sonst für nichts! --> Quest verwenden!
 */
final class ItemProviderQuest: NSObject, NSItemProviderWriting, NSItemProviderReading, Codable {
    private var id: String
    private var answers: [String]
    private var question: String
    private var imageData: Data?
    private var questionType: QuestionType
    private var locationPolygonPoints: [[String]]
    
    var quest: Quest {
        var image: UIImage? = nil
        if let imageData = imageData {
            image = UIImage(data: imageData)
        }
        var locationPoints: [CLLocationCoordinate2D] = []
        for loc in locationPolygonPoints {
            guard let latitudeString = loc.first, let longitudeString = loc.last, let latitude = Double(latitudeString), let longitude = Double(longitudeString) else {
                break
            }
            let point = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            locationPoints.append(point)
        }
        
        var quest = Quest(answers: answers, question: question, image: image, questionType: questionType, locationPolygonPoints: locationPoints)
        quest.id = id
        return quest
    }
    
    init(quest: Quest) {
        self.id = quest.id
        self.answers = quest.answers
        self.question = quest.question
        if let image = quest.image {
            self.imageData = UIImagePNGRepresentation(image)
        }
        self.questionType = quest.questionType
        var locs: [[String]] = []
        for loc in quest.locationPolygonPoints {
            locs.append(["\(loc.latitude)", "\(loc.longitude)"])
        }
        self.locationPolygonPoints = locs
    }
    
    
    // MARK: - NSItemProviderWriting
    
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [(kUTTypeData as String)]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        let progress = Progress(totalUnitCount: 100)
        
        do {
            let data = try JSONEncoder().encode(self)
            progress.completedUnitCount = 100
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
        return progress
    }
    
    // MARK: - NSItemProviderReading
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [(kUTTypeData as String)]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> ItemProviderQuest {
        let decoder = JSONDecoder()
        
        do {
            let questClass = try decoder.decode(ItemProviderQuest.self, from: data)
            return questClass
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
