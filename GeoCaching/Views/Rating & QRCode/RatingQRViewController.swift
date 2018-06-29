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
    
    var activeGameCtrl: ActiveGameController!
    
    var ratingQRDelegate: RatingQRDelegate? = nil
    
    private lazy var userDidCloseIntentionally = false
    
    private var ratingQRState: RatingQR = .rating
    var ratingQRView = RatingQRView()
    
    private(set) var ratingSliderValue : Int = 0

    @IBOutlet weak var closeButton: UIButton!
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
        topImage.image = #imageLiteral(resourceName: "yoga")
        topImage.contentMode = .scaleAspectFill
        
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.masksToBounds = true
        backgroundView.backgroundColor = AppColor.background
        
        submitButton.setTitleColor(AppColor.tint, for: .normal)
        submitButton.layer.borderColor = AppColor.tint.cgColor
        submitButton.layer.borderWidth = 2
        submitButton.layer.cornerRadius = 10
        
        switchButtonTitle()
        
        closeButton.layer.cornerRadius = 10
        closeButton.layer.borderColor = AppColor.tint.cgColor
        closeButton.layer.borderWidth = 2
        closeButton.backgroundColor = AppColor.background
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
        view.game = activeGameCtrl.game
        view.delegate = self
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
            //Slidervalue hochladen
            loadQRView()
        }
        else if ratingQRState == .qr {
            dismissScreen()
        }
    }
    
    @IBAction func closeScreen(_ sender: UIButton) {
        dismissScreen()
    }
    
    func changedSliderValue(sliderValue: Int) {
        ratingSliderValue = sliderValue
    }
    
    private func dismissScreen() {
        userDidCloseIntentionally = true
        guard let delegate = ratingQRDelegate else { return }
        delegate.closedRatingQRCreen(vc: self)
    }
}
