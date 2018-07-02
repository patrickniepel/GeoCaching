//
//  RatingQRViewController.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 27.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

enum RatingQR {
    case rating
    case qr
}

class RatingQRViewController: UIViewController, RatingSliderDelegate {
    
    var game: Game!
    var userPoints: Int = 0
    
    var ratingQRDelegate: RatingQRDelegate? = nil
    
    private lazy var userDidCloseIntentionally = false
    
    private var ratingQRState: RatingQR = .qr
    var ratingQRView = RatingQRView()
    
    //Default rating value
    private(set) var ratingSliderValue : Int = 1

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadViewType()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if !userDidCloseIntentionally {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func setupLayout() {
        topImage.clipsToBounds = true
        topImage.image = game.image ?? #imageLiteral(resourceName: "yoga")
        topImage.contentMode = .scaleAspectFill
        
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.masksToBounds = true
        backgroundView.backgroundColor = AppColor.background
        
        submitButton.setTitleColor(AppColor.tint, for: .normal)
        submitButton.layer.borderColor = AppColor.tint.cgColor
        submitButton.layer.borderWidth = 2
        submitButton.layer.cornerRadius = 10
        
        switchButtonTitle()
    }
    
    private func switchButtonTitle() {
        let buttonTitle = ratingQRState == .rating ? "Show Coupon" : "Close"
        submitButton.setTitle(buttonTitle, for: .normal)
    }
    
    private func loadViewType() {

        if ratingQRState == .rating {
            ratingQRView = UINib(nibName: "RatingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! RatingView
        }
        else if ratingQRState == .qr {
            ratingQRView = UINib(nibName: "QRCodeView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! QRCodeView
        }
        
        prepareInfos(view: ratingQRView)
        typeView.frame = ratingQRView.bounds
        typeView.addSubview(ratingQRView)
    }
    
    private func prepareInfos(view: RatingQRView) {
        view.game = game
        view.delegate = self
        view.userPoints = userPoints
        view.setupLayout()
    }
    
    private func loadQRView() {
        ratingQRState = .qr
        switchButtonTitle()
        ratingQRView.removeFromSuperview()
        loadViewType()
    }
    
    @IBAction func submit(_ sender: UIButton) {
        if ratingQRState == .rating {
            updateDatabases()
            
            print("SLIDERVALUE", ratingSliderValue)
            loadQRView()
        }
        else if ratingQRState == .qr {
            dismissScreen()
        }
    }
    
    private func updateDatabases() {
        GameUploadController().updateRating(ofGameID: game.id, withRating: ratingSliderValue)
        let profileCtrl = ProfileController()
        profileCtrl.updateUserPoints(pointsToAdd: userPoints)
        profileCtrl.updateUserProfile(newAchivementType: .firstOfAll)
    }
    
    private func dismissScreen() {
        userDidCloseIntentionally = true
        guard let delegate = ratingQRDelegate else { return }
        delegate.userClosedRatingQRScreen(vc: self)
    }
    
    func changedSliderValue(sliderValue: Int) {
        ratingSliderValue = sliderValue
        print("Quests", game.toDictionary)
    }
}
