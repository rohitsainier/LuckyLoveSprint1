//
//  ViewController.swift
//  LuckyInLove
//
//  Created by Ruchit on 05/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {

    //MARK:- Outlets
    @IBOutlet weak var txtEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
       self.configUI()
    }
    //MARK:- Helper Methods
    
    func configUI(){
        self.btnLogin.layer.cornerRadius = CGFloat(CornerRadius.kButtonCornerRadius)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    //MARK:- UIGestureRecognizer delegate Methods
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == navigationController?.interactivePopGestureRecognizer else {
            return true // default value
        }
        // Disable pop gesture in two situations:
        // 1) when the pop animation is in progress
        // 2) when user swipes quickly a couple of times and animations don't have time to be performed
        return (navigationController?.viewControllers.count)! > 1
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return (otherGestureRecognizer is UIScreenEdgePanGestureRecognizer)
    }
    //MARK:- Button Action
    
    @IBAction func LoginButtonAction(_ sender: Any) {
        guard let username = txtEmail.text else{return}
        guard let password = txtPassword.text else{return}
        if username == ""{
            displayToast("Please enter your username")
        }
        else if password == ""{
            displayToast("Please enter your password")
        }
        else{
            let params: [String: Any] = ["email": username,"Password": password]
            GCD.USER.LOGIN.async {
                APIManager.sharedInstance.I_AM_COOL(params: params, api: API.USER.Login, Loader: true, isMultipart: false) { (responseData) in
                    print(responseData)
                AppDelegate().sharedDelegate().navigateToDashboard()
                }
            }
            
        }
        
    }
    
    @IBAction func SignupButtonAction(_ sender: Any) {
        let vc: SignupVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func ForgotPasswordButtonAction(_ sender: Any) {
    }
    
    //MARK: UITextFieldDelegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == txtEmail {
            txtPassword.becomeFirstResponder()
        }
        return true
    }
}

