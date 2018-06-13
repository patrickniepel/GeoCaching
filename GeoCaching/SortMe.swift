//
//  SortMe.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import CoreLocation

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
    
    var quests = [Quest(answers: ["Hier steht die Antwort 1",
                                  "Hier steht die Antwort 2",
                                  "Hier steht die Antwort 3",
                                  "Hier steht die Antwort 4"],
                        question: "Hier steht die Frage 1",
                        image: nil, questionType: QuestionType.fourChoices,
                        locationPolygonPoints: [CLLocationCoordinate2D(latitude: 50.325067, longitude: 11.941689)]),
                  Quest(answers: ["Hier steht die Antwort 1",
                                  "Hier steht die Antwort 2",
                                  "Hier steht die Antwort 3",
                                  "Hier steht die Antwort 4"],
                        question: "Hier steht die Frage 2",
                        image: nil, questionType: QuestionType.fourChoices,
                        locationPolygonPoints: [CLLocationCoordinate2D(latitude: 50.323757, longitude: 11.939341)]),
                  Quest(answers: ["Hier steht die Antwort 1",
                                  "Hier steht die Antwort 2",
                                  "Hier steht die Antwort 3",
                                  "Hier steht die Antwort 4"],
                        question: "Hier steht die Frage 3",
                        image: nil, questionType: QuestionType.fourChoices,
                        locationPolygonPoints: [CLLocationCoordinate2D(latitude: 50.323428, longitude: 11.936133)]),
                  Quest(answers: ["Hier steht die Antwort 1",
                                  "Hier steht die Antwort 2",
                                  "Hier steht die Antwort 3",
                                  "Hier steht die Antwort 4"],
                        question: "Hier steht die Frage 4",
                        image: nil, questionType: QuestionType.fourChoices,
                        locationPolygonPoints: [CLLocationCoordinate2D(latitude: 50.324984, longitude: 11.932994)]),
                  Quest(answers: ["Hier steht die Antwort 1",
                                  "Hier steht die Antwort 2",
                                  "Hier steht die Antwort 3",
                                  "Hier steht die Antwort 4"],
                        question: "Hier steht die Frage 5",
                        image: nil, questionType: QuestionType.fourChoices,
                        locationPolygonPoints: [CLLocationCoordinate2D(latitude: 50.326696, longitude: 11.932930)]),
                  Quest(answers: ["Hier steht die Antwort 1",
                                  "Hier steht die Antwort 2",
                                  "Hier steht die Antwort 3",
                                  "Hier steht die Antwort 4"],
                        question: "Hier steht die Frage 6",
                        image: nil, questionType: QuestionType.fourChoices,
                        locationPolygonPoints: [CLLocationCoordinate2D(latitude: 50.325792, longitude: 11.935548)]),
                  Quest(answers: ["Hier steht die Antwort 1",
                                  "Hier steht die Antwort 2",
                                  "Hier steht die Antwort 3",
                                  "Hier steht die Antwort 4"],
                        question: "Hier steht die Frage 7",
                        image: nil, questionType: QuestionType.fourChoices,
                        locationPolygonPoints: [CLLocationCoordinate2D(latitude: 50.324141, longitude: 11.936387)]),
                  Quest(answers: ["Hier steht die Antwort 1",
                                  "Hier steht die Antwort 2",
                                  "Hier steht die Antwort 3",
                                  "Hier steht die Antwort 4"],
                        question: "Hier steht die Frage 8",
                        image: nil, questionType: QuestionType.fourChoices,
                        locationPolygonPoints: [CLLocationCoordinate2D(latitude: 50.321826, longitude: 11.938286)]),
                  Quest(answers: ["Hier steht die Antwort 1",
                                  "Hier steht die Antwort 2",
                                  "Hier steht die Antwort 3",
                                  "Hier steht die Antwort 4"],
                        question: "Hier steht die Frage 9",
                        image: nil, questionType: QuestionType.fourChoices,
                        locationPolygonPoints: [CLLocationCoordinate2D(latitude: 50.322175, longitude: 11.942642)]),
                  Quest(answers: ["Hier steht die Antwort 1",
                                  "Hier steht die Antwort 2",
                                  "Hier steht die Antwort 3",
                                  "Hier steht die Antwort 4"],
                        question: "Hier steht die Frage 10",
                        image: nil, questionType: QuestionType.fourChoices,
                        locationPolygonPoints: [CLLocationCoordinate2D(latitude: 50.324572, longitude: 11.945818)])]
}

















