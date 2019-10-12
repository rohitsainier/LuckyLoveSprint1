//
//  SignupVC.swift
//  LuckyInLove
//
//  Created by Ruchit on 05/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import UIKit

class SignupVC: UIViewController, UITextFieldDelegate  {

    //MARK:- Outlets
    @IBOutlet weak var txtName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtGender: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var txtConfirmPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var btnSignup: UIButton!
    
    //MARK:-View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Set Navigation
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.setupNavigation()
        
    }
    
    //MARK:- Navigation
    func setupNavigation() {
        self.title = "Signup"
        self.btnSignup.layer.cornerRadius = CGFloat(CornerRadius.kButtonCornerRadius)
    }
    
    
    //MARK:- Button Action
    
    @IBAction func SignupButtonAction(_ sender: Any) {
    }
    
    @IBAction func SignInButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
