//
//  CompleteSignUp.swift
//  LuckyInLove
//
//  Created by Rohit Saini on 16/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import UIKit
import RangeSeekSlider

class CompleteSignUp: UIViewController {
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var distanceRangeSlider: RangeSeekSlider!
    @IBOutlet weak var ageRangeSlider: RangeSeekSlider!
    
    @IBOutlet weak var aboutTxt: UITextView!
    @IBOutlet weak var genderMaleBtn: UIButton!
    
    @IBOutlet weak var genderOtherBtn: UIButton!
    @IBOutlet weak var genderFemaleBtn: UIButton!
    
    @IBOutlet weak var DOBLbl: UILabel!
    
    @IBOutlet weak var interestedMaleBtn: UIButton!
    
    @IBOutlet weak var interestedFemaleBtn: UIButton!
    
    @IBOutlet weak var interestedOtherBtn: UIButton!
    var gender = "female"
    var interestedGender = "female"
    var age = 18
    var maxAge = 0
    var minAge = 0
    var maxDis = 0
    var minDis = 0
    var about = ""
    var firstname = ""
    var lastname = ""
    var email = ""
    var password = ""
    var profilePic: UIImage = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configUI()
    }
    
    private func configUI(){
        DobGesture()
        aboutTxt.layer.cornerRadius = 5
        aboutTxt.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        aboutTxt.layer.borderWidth = 1
        signUpBtn.layer.cornerRadius = 8
        genderMaleBtn.layer.cornerRadius = 5
        genderOtherBtn.layer.cornerRadius = 5
        if #available(iOS 11.0, *) {
            genderMaleBtn.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 11.0, *) {
            genderOtherBtn.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        genderMaleBtn.layer.borderWidth = 1
        genderMaleBtn.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.1333333333, blue: 0.3215686275, alpha: 1)
        genderFemaleBtn.layer.borderWidth = 1
        genderFemaleBtn.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.1333333333, blue: 0.3215686275, alpha: 1)
        genderOtherBtn.layer.borderWidth = 1
        genderOtherBtn.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.1333333333, blue: 0.3215686275, alpha: 1)
        
        
        
        
        interestedMaleBtn.layer.cornerRadius = 5
        interestedOtherBtn.layer.cornerRadius = 5
        if #available(iOS 11.0, *) {
            interestedMaleBtn.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 11.0, *) {
            interestedOtherBtn.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        interestedMaleBtn.layer.borderWidth = 1
        interestedMaleBtn.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.1333333333, blue: 0.3215686275, alpha: 1)
        interestedFemaleBtn.layer.borderWidth = 1
        interestedFemaleBtn.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.1333333333, blue: 0.3215686275, alpha: 1)
        interestedOtherBtn.layer.borderWidth = 1
        interestedOtherBtn.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.1333333333, blue: 0.3215686275, alpha: 1)
        
        
        
        
    }
    
    
    //MARK: - maleBtnIsPressed
       @IBAction func genderMaleBtnIsPressed(_ sender: UIButton) {
           gender = "male"
           genderMaleBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: UIControl.State.normal)
           genderMaleBtn.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.1333333333, blue: 0.3215686275, alpha: 1)
           genderFemaleBtn.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: UIControl.State.normal)
           genderFemaleBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
           genderOtherBtn.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: UIControl.State.normal)
           genderOtherBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
       }
       
       //MARK: - femaleBtnIsPressed
       @IBAction func genderFemaleBtnIsPressed(_ sender: UIButton) {
           gender = "female"
           genderFemaleBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: UIControl.State.normal)
           genderFemaleBtn.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.1333333333, blue: 0.3215686275, alpha: 1)
           genderMaleBtn.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: UIControl.State.normal)
           genderMaleBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
           genderOtherBtn.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: UIControl.State.normal)
           genderOtherBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
       }
       
       //MARK: - otherBtnIsPressed
       @IBAction func genderOtherBtnIsPressed(_ sender: UIButton) {
           gender = "other"
           genderOtherBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: UIControl.State.normal)
           genderOtherBtn.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.1333333333, blue: 0.3215686275, alpha: 1)
           genderFemaleBtn.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: UIControl.State.normal)
           genderFemaleBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
           genderMaleBtn.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: UIControl.State.normal)
           genderMaleBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
       }
    
    
    
    //MARK: - maleBtnIsPressed
       @IBAction func interMaleBtnIsPressed(_ sender: UIButton) {
           interestedGender = "male"
           interestedMaleBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: UIControl.State.normal)
           interestedMaleBtn.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.1333333333, blue: 0.3215686275, alpha: 1)
           interestedFemaleBtn.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: UIControl.State.normal)
           interestedFemaleBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
           interestedOtherBtn.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: UIControl.State.normal)
           interestedOtherBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
       }
       
       //MARK: - femaleBtnIsPressed
       @IBAction func interFemaleBtnIsPressed(_ sender: UIButton) {
           interestedGender = "female"
           interestedFemaleBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: UIControl.State.normal)
           interestedFemaleBtn.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.1333333333, blue: 0.3215686275, alpha: 1)
           interestedMaleBtn.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: UIControl.State.normal)
           interestedMaleBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
           interestedOtherBtn.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: UIControl.State.normal)
           interestedOtherBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
       }
       
       //MARK: - otherBtnIsPressed
       @IBAction func interOtherBtnIsPressed(_ sender: UIButton) {
           interestedGender = "other"
           interestedOtherBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: UIControl.State.normal)
           interestedOtherBtn.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.1333333333, blue: 0.3215686275, alpha: 1)
           interestedFemaleBtn.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: UIControl.State.normal)
           interestedFemaleBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
           interestedMaleBtn.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: UIControl.State.normal)
           interestedMaleBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
       }
    
    
    //MARK: - DobGesture
       private func DobGesture() {
           DOBLbl.addTapGesture {
               RPicker.selectDate(title: "Select Date...", hideCancel: false,  minDate: nil, maxDate: Date(), didSelectDate: { [unowned self](date) in
                   self.DOBLbl.text = date.dateString("dd MMMM yyy")
                   let year = date.dateString("yyy")
                   let currentYear = Date().dateString("yyy")
                self.age = (Int(year) ?? 0) - (Int(currentYear) ?? 0)
               })
           }
       }
    
    @IBAction func clickSignUpBtn(_ sender: UIButton) {
        about = aboutTxt.text
        let params: [String: Any] = ["about": about,
        "email": email,
        "max_dist_pref": distanceRangeSlider.maxValue,
        "gender": gender,
        "device_token": password,
        "max_age_pref": ageRangeSlider.maxValue,
        "min_dist_pref": distanceRangeSlider.minValue,
        "lname": lastname,
        "password": password,
        "gender_pref": interestedGender,
        "fname": firstname,
        "device": "ios",
        "location_long": 34,
        "profession": "IOS Developer",
        "dob": "10/12/1990",
        "min_age_pref": 18,
        "country": "India",
        "location_lat": 72]
        GCD.USER.REGISTER.async {
            APIManager.sharedInstance.I_AM_COOL(params: params, api: API.USER.Register, Loader: true, isMultipart: false) { [unowned self](responseData) in
                if responseData != nil{                             //if response is not empty
                    do {
                        let success = try JSONDecoder().decode(RegisterModel.self, from: responseData!) // decode the response into SignUpModel
                        switch success.error{
                        case false:
                            AppModel.shared.loggedInUser = success.body
                            self.uploadRegisterUserProfilePic(id: success.body?.id ?? "", AuthToken: success.body?.authToken ?? "", pic: self.profilePic)
                        default:
                            print("Error in register the user")
                        }
                    }
                    catch let err {
                        print("Err", err)
                    }
                }
            }
        }
        
        
        
      

    }
    
    private func uploadRegisterUserProfilePic(id: String,AuthToken: String,pic: UIImage){
        let params: [String: Any] = ["id":id,"AuthToken":AuthToken]
        GCD.USER.UPLOAD_PICTURE.async {
            APIManager.sharedInstance.MULTIPART_IS_COOL(compressImage(image: self.profilePic), param: params, api: API.USER.UploadPicture, login: true) { (responseData) in
                if responseData != nil{                             //if response is not empty
                    do {
                        let success = try JSONDecoder().decode(UploadPictureModel.self, from: responseData!) // decode the response into SignUpModel
                        switch success.error{
                        case false:
                            self.registerFirebaseUser()
                        default:
                            print("Error in register the user")
                        }
                    }
                    catch let err {
                        print("Err", err)
                    }
                }
            }
        }
    }
    
    private func registerFirebaseUser(){
        User.registerUser(withName: firstname + lastname, email: email, gender: gender, password: password, profilePic: profilePic, fcmToken: "not configured yet", notificationCount: 0, messageCount: 0, location: ["lat":0,"long":0]) { (loginHandler) in
            if loginHandler == nil{
                displayToast("A verification link has been sent to your registered email id please verify to Login")
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: LoginVC.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
            }
            else{
                displayToast(loginHandler!)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
