//
//  SignupVC.swift
//  LuckyInLove
//
//  Created by Ruchit on 05/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import UIKit
import MobileCoreServices


class SignupVC: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {

    //MARK:- Outlets
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var firstNameTxt: SkyFloatingLabelTextField!
    @IBOutlet weak var lastNameTxt: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTxt: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTxt: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPasswordTxt: SkyFloatingLabelTextField!
    @IBOutlet weak var btnSignup: UIButton!
    
    @IBOutlet weak var alreadyAUserLbl: UILabel!
    
    
    //MARK:-View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
   
    
    //MARK:- Navigation
    func configUI() {
        profilePic.layer.cornerRadius =  profilePic.frame.height / 2
        profilePic.layer.masksToBounds = true
        btnSignup.layer.cornerRadius = CGFloat(CornerRadius.kButtonCornerRadius)
        
        //Already user action
        alreadyAUserLbl.addTapGesture { [unowned self] in
            self.NaviagateToLoginScreen()
        }
        
        //Image Action
        profilePic.addTapGesture { [unowned self] in
            self.uploadImage()
        }
        
        
    }
    
    
    //MARK:- Button Action
    
    @IBAction func SignupButtonAction(_ sender: Any) {
        registerUser()
    }
    
    private func NaviagateToLoginScreen(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    private func registerUser(){
//        guard let firstname = firstNameTxt.text else{return}
//        guard let lastname = lastNameTxt.text else{return}
//        guard let email = emailTxt.text else{return}
//        guard let password = passwordTxt.text else{return}
//        guard let confirmPassword = confirmPasswordTxt.text else{return}
//
//        if firstname == ""{
//            displayToast("Please enter firstname")
//        }
//        else if lastname == ""{
//            displayToast("Please enter lastname")
//        }
//        else if email == ""{
//            displayToast("Please enter email")
//        }
//        else if password == ""{
//            displayToast("Please enter password")
//        }
//        else if confirmPassword == ""{
//            displayToast("Please confirm password")
//        }
//        else if password != confirmPassword{
//            displayToast("Confirm Password is not same as password")
//        }
//        else{
//            let params: [String: Any] = ["fname":"Rohit","lname":"Saini","email":"rohitsainier@gmail.com","password":"12345678","gender":"male","gender_pref":"female","device":"ios","device_token":"12345678","profession":"IOS Developer","country":"India","max_age_pref":30,"min_age_pref":18,"max_dist_pref":50,"min_dist_pref":1,"about":"Hola amigos yo soy rohit saini"]
//            let imageData = compressImage(image: profilePic.image!)
//            GCD.USER.REGISTER.async {
//                APIManager.sharedInstance.I_AM_COOL(params: params, api: API.USER.Register, Loader: true, isMultipart: false) { (responseData) in
//                    print(responseData)
//                }
//            }
        //}
        
        User.registerUser(withName: "Dummy Saini", email: "Dummy@gmail.com", password: "12345678", profilePic: profilePic.image!, fcmToken: "not configured yet", notificationCount: 0, messageCount: 0, location: ["lat":0,"long":0]) { (loginHandler) in
            if loginHandler == nil{
                self.view.sainiShowToast(message: "User Register Successfully")
            }
            else{
                self.view.sainiShowToast(message: loginHandler!)
            }
        }
    }
    
    // MARK: - Upload Image
        @objc func uploadImage()
        {
            let actionSheet: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                print("Cancel")
            }
            actionSheet.addAction(cancelButton)
            
            let cameraButton = UIAlertAction(title: "Camera", style: .default)
            { _ in
                print("Camera")
                self.onCaptureImageThroughCamera()
            }
            
            
            actionSheet.addAction(cameraButton)
            
            
            
            let galleryButton = UIAlertAction(title: "Gallery", style: .default)
            { _ in
                print("Gallery")
                self.onCaptureImageThroughGallery()
            }
            actionSheet.addAction(galleryButton)
            
            
            actionSheet.popoverPresentationController?.sourceView = self.view
            actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            actionSheet.popoverPresentationController?.permittedArrowDirections = []
            actionSheet.view.tintColor = colorFromHex(hex: "#E91E63", alpha: 1)
            self.present(actionSheet, animated: true, completion: nil)
        }
        
        @objc open func onCaptureImageThroughCamera()
        {
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                //displayToast("Your device has no camera")
                
            }
            else {
                let imgPicker = UIImagePickerController()
                imgPicker.delegate = self
                imgPicker.sourceType = .camera
                imgPicker.mediaTypes = [kUTTypeImage] as [String]
                
                present(imgPicker, animated: true, completion: {() -> Void in
                })
            }
        }
        
        @objc open func onCaptureImageThroughGallery()
        {
            self.dismiss(animated: true, completion: nil)
            DispatchQueue.main.async {
                let imgPicker = UIImagePickerController()
                imgPicker.delegate = self
                imgPicker.sourceType = .photoLibrary
                imgPicker.mediaTypes = [kUTTypeImage] as [String]
                self.present(imgPicker, animated: true, completion: {() -> Void in
                })
            }
        }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        handleImageSelectedForInfo(info: info,picker: picker)
    }
        
       
        //MARK:- Selected Image
        private func handleImageSelectedForInfo(info: [UIImagePickerController.InfoKey: Any],picker: UIImagePickerController){
            //Image Picking Process
            var selectedImage: UIImage?
            if let editedImage = (info[UIImagePickerController.InfoKey.editedImage] as? UIImage){
                selectedImage = editedImage
            }
            else if let originalImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage){
                selectedImage = originalImage
            }
            
            if let finalImage = selectedImage{
                picker.dismiss(animated: true, completion: {() -> Void in
                    print("Now")
                    self.profilePic.image = finalImage
                })
            }
        }
}
