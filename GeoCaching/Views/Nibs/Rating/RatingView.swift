//
//  RatingView.swift
//  GeoCaching
//
//  Created by Patrick Niepel on 27.06.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class RatingView: RatingQRView {
    
    @IBOutlet weak var gratulationsTitle: UILabel!
    @IBOutlet weak var gratulationsMessage: UILabel!
    @IBOutlet weak var rateThisTourLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var currentRatingLabel: UILabel!
    @IBOutlet weak var userRatingLabel: UILabel!
    @IBOutlet weak var ratingBackgroundView: UIView!
    
    var ratingTextLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Ratings Yet"
        label.textColor = AppColor.tint
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica Neue", size: 20)
        
        return label
    }()
    
    var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        return stackView
    }()
    
    private var starImages = [UIImageView]()
    
    private var currentRating = 0
    
    override func setupLayout() {
        
        currentRating = game?.rating ?? 0
        downloadCurrentRating()
        
        self.backgroundColor = AppColor.background
        gratulationsTitle.textColor = .white
        
        gratulationsMessage.textColor = .white
        gratulationsMessage.numberOfLines = 0
        gratulationsMessage.text = "You are one of the few that have made it this far!"
        
        scoreLabel.textColor = .white
        scoreLabel.text = "Your score: \(userPoints)"
        
        rateThisTourLabel.textColor = .white
        currentRatingLabel.textColor = .white
        
        ratingBackgroundView.backgroundColor = AppColor.background
        
        slider.value = 1
        slider.minimumValue = 1
        slider.maximumValue = 5
        slider.thumbTintColor = AppColor.tint
        slider.minimumTrackTintColor = AppColor.tint
        slider.maximumTrackTintColor = .white
        
        userRatingLabel.textColor = AppColor.tint
        userRatingLabel.text = "1"
    }
    
    private func checkRating() {
        
        if currentRating == 0 {
            addRatingTextLabel()
        }
        else {
            createStarImages(for: currentRating)
            addStarImages()
        }
    }
    
    private func addRatingTextLabel() {
        ratingBackgroundView.addSubview(ratingTextLabel)
        
        addConstraint(NSLayoutConstraint(item: ratingTextLabel, attribute: .top, relatedBy: .equal, toItem: ratingBackgroundView, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: ratingTextLabel, attribute: .left, relatedBy: .equal, toItem: ratingBackgroundView, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: ratingTextLabel, attribute: .right, relatedBy: .equal, toItem: ratingBackgroundView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: ratingTextLabel, attribute: .bottom, relatedBy: .equal, toItem: ratingBackgroundView, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    private func addStarImages() {
        starImages.forEach { imageView in
            stackView.addArrangedSubview(imageView)
        }
        
        ratingBackgroundView.addSubview(stackView)
        
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: ratingBackgroundView, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: ratingBackgroundView, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: ratingBackgroundView, attribute: .centerX, multiplier: 1, constant: 0))
    }
    
    private func createStarImages(for count: Int) {
        
        for _ in 0..<count {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: "star")
            imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true
            
            starImages.append(imageView)
        }
    }
    
    func downloadCurrentRating() {
        guard let gameID = game?.id else { return }

        GameDownloadController().downloadRating(for: gameID) { (rating, error) in
            if error != nil {
                print("Error - ratingView - downloadcurrentRating", error)
                return
            }
            
            if let rating = rating {
                self.currentRating = rating

                DispatchQueue.main.async(execute: {
                    self.checkRating()
                })
            }
        }
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let sliderValue = Int(sender.value)
        userRatingLabel.text = "\(sliderValue)"
        
        guard let delegate = delegate else { return }
        delegate.changedSliderValue(sliderValue: sliderValue)
    }
}
