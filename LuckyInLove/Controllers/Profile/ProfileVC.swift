//
//  ProfileVC.swift
//  LuckyInLove
//
//  Created by Ruchit on 06/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var btnProfileMenu: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI()
    }
    
    func configUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.title = "Profile"
      
    }

    @IBAction func ProfileMenuButtonAction(_ sender: Any) {
        self.showAlert(title: "", message: "Coming soon")
    }
    

}
