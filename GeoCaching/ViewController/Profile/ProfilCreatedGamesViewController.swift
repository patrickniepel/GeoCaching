//
//  ProfilCreatedGamesViewController.swift
//  GeoCaching
//
//  Created by Philipp Knoblauch on 02.07.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class ProfilCreatedGamesViewController: UIViewController {
    
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var text1Label: UILabel!
    @IBOutlet weak var text2Label: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundView.backgroundColor = AppColor.background
        text1Label.textColor = AppColor.tint
        text2Label.textColor = AppColor.tint
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
