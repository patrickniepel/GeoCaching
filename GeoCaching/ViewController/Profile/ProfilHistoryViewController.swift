//
//  ProfilHistoryViewController.swift
//  GeoCaching
//
//  Created by Philipp Knoblauch on 02.07.18.
//  Copyright © 2018 Patrick Niepel. All rights reserved.
//

import UIKit

class ProfilHistoryViewController: UIViewController {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        backgroundView.backgroundColor = AppColor.background
        textLabel.textColor = AppColor.tint
        
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
