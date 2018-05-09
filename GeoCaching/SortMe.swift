//
//  SortMe.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 08.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

struct DummyContent {
    
    public static var sharedInstance = DummyContent()
    
    private init() {}
    
    
    
    var currentUser = User(id: "the id1", username: "GaryVee", userImage: UIImage(named: "gary")!,
                           isPresenter: false, points: 2_364_477,
                           earnedAchivements: [Achivement(type: AchivementType.geoSchnitzler),
                                               Achivement(type: AchivementType.noob),
                                               Achivement(type: AchivementType.noob),
                                               Achivement(type: AchivementType.noob),
                                               Achivement(type: AchivementType.noob)])
    
    var users = [User(id: "the id2", username: "MH", userImage: UIImage(named: "gary")!,
                      isPresenter: false, points: 1_364_477,
                      earnedAchivements: [Achivement(type: AchivementType.geoSchnitzler),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob)]),
                 User(id: "the id3", username: "PK", userImage: UIImage(named: "gary")!,
                      isPresenter: false, points: 2_364_477,
                      earnedAchivements: [Achivement(type: AchivementType.geoSchnitzler),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob)]),
                 User(id: "the id4", username: "PD", userImage: UIImage(named: "gary")!,
                      isPresenter: false, points: 3_364_477,
                      earnedAchivements: [Achivement(type: AchivementType.geoSchnitzler),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob)]),
                 User(id: "the id5", username: "PN", userImage: UIImage(named: "gary")!,
                      isPresenter: false, points: 4_364_477,
                      earnedAchivements: [Achivement(type: AchivementType.geoSchnitzler),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob)]),
                 User(id: "the id6", username: "Username 1", userImage: UIImage(named: "gary")!,
                      isPresenter: false, points: 4_364_477,
                      earnedAchivements: [Achivement(type: AchivementType.geoSchnitzler),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob)]),
                 User(id: "the id7", username: "Username 2", userImage: UIImage(named: "gary")!,
                      isPresenter: false, points: 4_364_477,
                      earnedAchivements: [Achivement(type: AchivementType.geoSchnitzler),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob)]),
                 User(id: "the id8", username: "Username 3", userImage: UIImage(named: "gary")!,
                      isPresenter: false, points: 4_364_477,
                      earnedAchivements: [Achivement(type: AchivementType.geoSchnitzler),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob),
                                          Achivement(type: AchivementType.noob)])]
}

















