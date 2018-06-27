//
//  SortMe.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

struct DummyContent {
    
    public static var sharedInstance = DummyContent()
    
    private init() {}
    
    
    
    var currentUser = User(id: "the id1", username: "GaryVee", userImage: UIImage(named: "gary")!,
                           isPresenter: false, points: 2_364_477,
                           earnedAchivements: [Achivement(type: AchivementType.firstOfAll),
                                               Achivement(type: AchivementType.firstChallengeCompleted),
                                               Achivement(type: AchivementType.firstChallengeAccepted)])
    
    var users = [User(id: "the id2", username: "MH", userImage: UIImage(named: "gary")!,
                      isPresenter: false, points: 1_364_477,
                      earnedAchivements: [Achivement(type: AchivementType.firstChallengeAccepted),
                                          Achivement(type: AchivementType.firstChallengeCompleted),
                                          Achivement(type: AchivementType.firstOfAll),
                                          Achivement(type: AchivementType.creator),
                                          Achivement(type: AchivementType.trendsetter)]),
                 User(id: "the id3", username: "PK", userImage: UIImage(named: "gary")!,
                      isPresenter: false, points: 2_364_477,
                      earnedAchivements: [Achivement(type: AchivementType.firstChallengeAccepted),
                                          Achivement(type: AchivementType.firstChallengeCompleted)]),
                 User(id: "the id4", username: "PD", userImage: UIImage(named: "gary")!,
                      isPresenter: false, points: 3_364_477,
                      earnedAchivements: [Achivement(type: AchivementType.firstChallengeAccepted),
                                          Achivement(type: AchivementType.firstChallengeCompleted),
                                          Achivement(type: AchivementType.firstOfAll),
                                          Achivement(type: AchivementType.creator),
                                          Achivement(type: AchivementType.trendsetter),
                                          Achivement(type: AchivementType.supporter),
                                          Achivement(type: AchivementType.becomeMmoderator)]),
                 User(id: "the id5", username: "PN", userImage: UIImage(named: "gary")!,
                      isPresenter: false, points: 4_364_477,
                      earnedAchivements: [Achivement(type: AchivementType.firstChallengeAccepted),
                                          Achivement(type: AchivementType.firstChallengeCompleted),
                                          Achivement(type: AchivementType.firstOfAll),
                                          Achivement(type: AchivementType.creator),
                                          Achivement(type: AchivementType.trendsetter)]),
                 User(id: "the id6", username: "Username 1", userImage: UIImage(named: "gary")!,
                      isPresenter: false, points: 4_364_477,
                      earnedAchivements: [Achivement(type: AchivementType.firstChallengeAccepted),
                                          Achivement(type: AchivementType.firstChallengeCompleted),
                                          Achivement(type: AchivementType.firstOfAll),
                                          Achivement(type: AchivementType.creator),
                                          Achivement(type: AchivementType.trendsetter),
                                          Achivement(type: AchivementType.supporter),
                                          Achivement(type: AchivementType.becomeMmoderator)]),
                 User(id: "the id7", username: "Username 2", userImage: UIImage(named: "gary")!,
                      isPresenter: false, points: 4_364_477,
                      earnedAchivements: [Achivement(type: AchivementType.firstChallengeAccepted),
                                          Achivement(type: AchivementType.firstChallengeCompleted),
                                          Achivement(type: AchivementType.firstOfAll),
                                          Achivement(type: AchivementType.creator),
                                          Achivement(type: AchivementType.trendsetter),
                                          Achivement(type: AchivementType.supporter),
                                          Achivement(type: AchivementType.becomeMmoderator),
                                          Achivement(type: AchivementType.move5km)]),
                 User(id: "the id8", username: "Username 3", userImage: UIImage(named: "gary")!,
                      isPresenter: false, points: 4_364_477,
                      earnedAchivements: [Achivement(type: AchivementType.firstChallengeAccepted)])]
    
    var universityGame = Game(name: "Hochschule Game",
                              shortDescription: "Kurze Beschreibung",
                              longDescription: "From the edge of the Fichtelgebirge, the Saale meanders in countless loops through Bayer to the Rhine. On its way it flows through picturesque valleys with wooded slopes, steep vineyards and rugged cliffs. On other passages, green meadows line the banks of wide fields and idyllic towns. Along the river, the Saale valley cycle path from Hof to Bayreuth covers about 370 kilometers (230 miles). On the way from its origin to the mouth of the Rhine, it flows past not only beatiful countryside, but also beautiful cities such as Oberkotzau and Neila.",
                              categories: [QuestCategory.nature, .under10km],
                              duration: 21,
                              length: 1.4,
                              image: UIImage(named: "yoga"),
                              rating: 5,
                              quests: [Quest(answers: ["Antwort 1"],
                                             question: "Wer ist der Ehrenbürger der Stadt Hof der im Dezember 1991 gestorben ist und in Verbindung mit der Hochschule steht.",
                                             image: UIImage(named: "yoga"),
                                             questionType: QuestionType.textInput,
                                             locationPolygonPoint: CLLocationCoordinate2D(latitude: 50.324774,
                                                                                          longitude: 11.941077), radius: 1000),
                                       Quest(answers: ["Norden", "Osten", "Süden", "nach links"],
                                             question: "In welche Himmelsrichtung zeigt dieser Pfeil an der Bushaltestelle?",
                                             image: UIImage(named: ""),
                                             questionType: QuestionType.fourChoices,
                                             locationPolygonPoint: CLLocationCoordinate2D(latitude: 50.323779,
                                                                                          longitude: 11.940323), radius: 1000),
                                       Quest(answers: ["20", "100", "1.000.000", "welches Dach?"],
                                             question: "Wie viele Fahrradstellplätze gibt es unter diesem Dach?",
                                             image: UIImage(named: "yoga"),
                                             questionType: QuestionType.number,
                                             locationPolygonPoint: CLLocationCoordinate2D(latitude: 50.324181,
                                                                                            longitude: 11.939300), radius: 1000),
                                       Quest(answers: ["2", "4", "8", "16"],
                                             question: "Wie viele Gebäudekomplexe besitzt die Hochschule Hof?",
                                             image: UIImage(named: "yoga"),
                                             questionType: QuestionType.number,
                                             locationPolygonPoint: CLLocationCoordinate2D(latitude: 50.324931,
                                                                                            longitude: 11.938181), radius: 1000),
                                       Quest(answers: ["Unisee"],
                                             question: "Wie heißt der bei Studenten beliebte See direkt neben der Universität? (Punkt 31 auf der Karte)",
                                             image: UIImage(named: "yoga"),
                                             questionType: QuestionType.textInput,
                                             locationPolygonPoint: CLLocationCoordinate2D(latitude: 50.326699,
                                                                                            longitude: 11.937674), radius: 1000),
                                       Quest(answers: ["PPMP"],
                                             question: "Lauf zurück in B010 und gebe den Code an der Tafel ein :)",
                                             image: UIImage(named: "yoga"),
                                             questionType: QuestionType.textInput,
                                             locationPolygonPoint: CLLocationCoordinate2D(latitude: 50.325568,
                                                                                          longitude: 11.939902), radius: 1000)
                                       ])
    var game1 = Game(name: "Game Name 1",
                              shortDescription: "Kurze Beschreibung",
                              longDescription: "Lange Beschreibung.",
                              categories: [QuestCategory.nature],
                              duration: 2300,
                              length: 10.4,
                              image: UIImage(named: "yoga"),
                              rating: 5,
                              quests: [
                                Quest(answers: ["Answer"],
                                             question: "Question ",
                                             image: UIImage(named: "yoga"),
                                             questionType: QuestionType.textInput,
                                             locationPolygonPoint: CLLocationCoordinate2D(latitude: 50.324774,
                                                                                          longitude: 11.941077), radius: 100)])
    var game2 = Game(name: "Game Name 2",
                     shortDescription: "Kurze Beschreibung",
                     longDescription: "Lange Beschreibung.",
                     categories: [QuestCategory.nature],
                     duration: 1234,
                     length: 12.34,
                     image: UIImage(named: "yoga"),
                     rating: 3,
                     quests: [
                        Quest(answers: ["Answer"],
                              question: "Question ",
                              image: UIImage(named: "yoga"),
                              questionType: QuestionType.textInput,
                              locationPolygonPoint: CLLocationCoordinate2D(latitude: 49.940474,
                                                                           longitude: 11.575026), radius: 100)])
    var game3 = Game(name: "Game Name 3",
                     shortDescription: "Kurze Beschreibung",
                     longDescription: "Lange Beschreibung.",
                     categories: [QuestCategory.nature],
                     duration: 2900,
                     length: 19.4,
                     image: UIImage(named: "yoga"),
                     rating: 4,
                     quests: [
                        Quest(answers: ["Answer"],
                              question: "Question ",
                              image: UIImage(named: "yoga"),
                              questionType: QuestionType.textInput,
                              locationPolygonPoint: CLLocationCoordinate2D(latitude: 52.474975,
                                                                           longitude: 13.454310), radius: 100)])
    var game4 = Game(name: "Game Name 4",
                     shortDescription: "Kurze Beschreibung",
                     longDescription: "Lange Beschreibung.",
                     categories: [QuestCategory.nature],
                     duration: 4900,
                     length: 120.4,
                     image: UIImage(named: "yoga"),
                     rating: 1,
                     quests: [
                        Quest(answers: ["Answer"],
                              question: "Question ",
                              image: UIImage(named: "yoga"),
                              questionType: QuestionType.textInput,
                              locationPolygonPoint: CLLocationCoordinate2D(latitude: 51.311580,
                                                                           longitude: 9.465461), radius: 100)])
    
}

class ActiveGameController {
    private(set) var game: Game
    private(set) var currentQuestIndex: Int = 0 {
        didSet {
            if currentQuestIndex >= game.quests.count {
                currentQuestIndex = game.quests.count - 1
            }
        }
    }
    var currentQuest: Quest {
        return game.quests[currentQuestIndex]
    }
    private var startDate: Date
    
    
    init(game: Game) {
        self.game = game
        startDate = Date()
    }
    
    
    func hasGameCompleted() -> Bool {
        return false
    }
    
    func isUserAnswerCorrect(userAnswer: String) -> Bool {
        let correctAnswer = currentQuest.correctAnswer.lowercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return correctAnswer ==  userAnswer.lowercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func nextQuest() {
        currentQuestIndex += 1
    }
    
    func isUserAllowedToAnswerTheQuest(userLocation: CLLocationCoordinate2D) -> Bool {
        let currentQuest = game.quests[currentQuestIndex]
        let questLocation = currentQuest.locationPolygonPoint
        let questRadius: Double = currentQuest.radius
        
        let point1 = MKMapPointForCoordinate(questLocation!)
        let point2 = MKMapPointForCoordinate(userLocation)
        let distance = MKMetersBetweenMapPoints(point1, point2)
        
        return distance < questRadius
    }
    
    // in die Location noch den Radius reinschreiben
    
    // 0. Alle Quests in die Karte einzeichnen
    //      - Alle Punkte miteinander verbinden?
    // 1. Button an neue Quest anpassen
    //      - Title
    //      - die Farbe vom Rand, je nachdem wie nah man dran ist
    // 2. Button aktivieren, wenn man nahgenug ist
    // 3. Quest an Patrick seinen ViewController schicken
    // 4. Ergebnis von Patrick erhalten und demenstprechend die Map und das Spiel anpassen
    
    
    // Startpunktzahl: +1000
    // Richtig:        + 100
    // Falsch:         -  50
    // Anzahl der Sekunden von 1000 abziehen - bis max. 1000
    //
    
    private var correctAnswers: Int = 0
    private var wrongAnswer: Int = 0
    
    func answeredCorrect() {
        correctAnswers += 1
    }
    
    func answeredWrong() {
        wrongAnswer += 1
    }
    
    func calculatePoints() -> Int {
        var totalPoints = 0
        totalPoints += (correctAnswers * 100)
        totalPoints -= (wrongAnswer * 50)
        
        let now = Date()
        let secondsSinceStart = Int(startDate.timeIntervalSince(now))
        
        let startPoints = 1000
        if secondsSinceStart < startPoints {
            totalPoints += (startPoints - secondsSinceStart)
        }
        
        return totalPoints
    }
    
}
















