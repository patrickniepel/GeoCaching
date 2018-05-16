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
        
        //setupScene()
        setupDesign()
        setupText()
        setupData()
  
    }
    
    override func viewDidLayoutSubviews() {
        setupScene()
    }
    
    
    // MARK: - Setup
    
    private func setupScene() {
        let scene = SCNScene(named: "testy2.dae")
        
       
        

        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera();
        cameraNode.position = SCNVector3(0, 0, 3)
        scene?.rootNode.addChildNode(cameraNode)

        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .ambient
        lightNode.position = SCNVector3(0, 5, 10)
        scene?.rootNode.addChildNode(lightNode)

        
        
        let rotateAction = SCNAction.repeatForever(SCNAction.rotate(by: 130, around: SCNVector3Make(0, 0, 1), duration: 100))
        scene?.rootNode.runAction(rotateAction)

        
        achievementView.allowsCameraControl = true
        achievementView.scene = scene
        achievementView.backgroundColor = AppColor.background

       
        
       
    }
    
    func setupText() {
        achievementNameLabel.text = achievement.type.title
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
