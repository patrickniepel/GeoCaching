//
//  ProfileAchievementDetailViewController.swift
//  GeoCaching
//
//  Created by Marcel Hagmann on 09.05.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit
import SceneKit

class ProfileAchievementDetailViewController: UIViewController {

    @IBOutlet weak var achievementView: SCNView!
    @IBOutlet weak var achievementNameLabel: UILabel!
    @IBOutlet weak var achievementDescriptionLabel: UILabel!
    
    var achievement: Achivement!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = achievement.type.title
        
        setupScene()
        setupDesign()
        setupText()
        setupData()
    }

    // MARK: - Setup
    
    private func setupScene() {
        
        let sceneName = AchievementController().getSceneName(for: achievement)
        let scene = SCNScene(named: sceneName)
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera();
        cameraNode.position = SCNVector3(0, 10, 40)
        scene?.rootNode.addChildNode(cameraNode)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(0, 20, 100)
        scene?.rootNode.addChildNode(lightNode)
        
//        let lightNode2 = SCNNode()
//        lightNode2.light = SCNLight()
//        lightNode2.light!.type = .omni
//        lightNode2.position = SCNVector3(0, 20, 300)
//        scene?.rootNode.addChildNode(lightNode2)

        let rotateAction = SCNAction.repeatForever(SCNAction.rotate(by: 130, around: SCNVector3Make(1, 1, 1), duration: 100))
        scene?.rootNode.runAction(rotateAction)

        achievementView.allowsCameraControl = true
        achievementView.scene = scene
        achievementView.backgroundColor = AppColor.background
    }
    
    func setupText() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        let dateString = dateFormatter.string(from: achievement.earnedDate!)
        achievementNameLabel.text = "\(achievement.type.title) - (\(dateString))"
        achievementDescriptionLabel.text = achievement.type.conditionDescription
        //achievementImageView.image = UIImage(named: "gary")
    }
    
    func setupDesign() {
        self.view.backgroundColor = AppColor.background
        achievementNameLabel.textColor = AppColor.text
        achievementDescriptionLabel.textColor = AppColor.text
    }
    
    func setupData() {
    }
}
