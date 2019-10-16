//
//  User.swift
//  LuckyInLove
//
//  Created by Rohit Saini on 13/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//


//
import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import CoreLocation

typealias Loginhandler = (_ msg:String?) -> Void //closure
class User: NSObject {
    
    //MARK: Properties
    let name: String
    let email: String
    let id: String
    var profilePic: String
    var latitude: Any
    var longitude: Any
    var fcmToken: String
    
    //MARK: Inits
    init(name: String, email: String, id: String, profilePic: String,latitude: Any,longitude: Any,fcmToken: String) {
        self.name = name
        self.email = email
        self.id = id
        self.profilePic = profilePic
        self.longitude = longitude
        self.latitude = latitude
        self.fcmToken = fcmToken
    }
    
    
    
    struct loginErrorCode {
        static let INVALID_EMAIL = "Invalid Email"
        static let UNVERIFIED_PHONENUMBER = "Mobile number is not Verified"
        static let WRONG_PASSWORD = "Wrong Password"
        static let PROBLEM_CONNECTING = "Problem Connecting to Databases "
        static let USER_NOT_FOUND = "User Not Found"
        static let EMAIL_ALREADY_USED = "Email Already used Try Another One"
        static let WEAK_PASSWORD = "Password should be alteast 6 characters long"
        static let SOMETHING_WENT_WRONG = "Something went wrong try Again"
        static let INVALID_CUSTOM_TOKEN = "Validation error with the custom token."
        static let CUSTOM_TOKEN_MISMATCH = "Service account and the API key belong to different projects."
        static let INVALID_CREDENTIAL = "Supplied credential is invalid. This could happen if it has expired or it is malformed."
        static let USER_DISABLE = "User's account is disabled."
        static let OPERATION_NOT_ALLOWED = "Email and password accounts are not enabled. Enable them in the Auth section of the Firebase console."
        static let TOO_MANY_REQUESTS = "Request has been blocked after an abnormal number of requests have been made from the caller device to the Firebase Authentication servers. Retry again after some time."
        static let ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL = "This account is already present with different credential"
        static let REQUIRES_RECENT_LOGIN = "Updating a user’s email is a security sensitive operation that requires a recent login from the user. This error indicates the user has not signed in recently enough. To resolve, reauthenticate the user by invoking reauthenticateWithCredential:completion: on FIRUser."
        static let PROVIDER_ALREADY_LINKED  = "Attempt to link a provider of a type already linked to this account."
        static let NO_SUCH_PROVIDER = "Attempt to unlink a provider that is not linked to the account."
        static let INVALID_USER_TOKEN = "The signed-in user's refresh token, that holds session information, is invalid. You must prompt the user to sign in again on this device."
        static let NETWORK_ERROR = "Network error occurred during the operation"
        static let USER_TOKEN_EXPIRED = "The current user’s token has expired, for example, the user may have changed account password on another device. You must prompt the user to sign in again on this device."
        static let INVALID_API_KEY = "Application has been configured with an invalid API key."
        static let USER_MISMATCH = "An attempt was made to reauthenticate with a user which is not the current user."
        static let CREDENTIAL_ALREADY_IN_USE = "An attempt to link with a credential that has already been linked with a different Firebase account."
        static let APP_NOT_AUTHORIZED = "App is not authorized to use Firebase Authentication with the provided API Key. go to the Google API Console and check under the credentials tab that the API key you are using has your application’s bundle ID whitelisted."
        static let EXPIRED_ACTION_CODE = "Action code is Expired"
        static let INVALID_ACTION_CODE = "Action code is Invalid"
        static let INVALID_MESSAGE_PAYLOAD = "Message payload is not valid"
        static let INVALID_SENDER = "Sender is not valid"
        static let INVALID_RECIPIENT_EMAIL = "r]Recipient mail is not valid"
        static let KEYCHAIN_ERROR = "Error in keychain"
        static let INTERNAL_ERROR = "Some internal Error"
        
    }//errorCodes
    
    class func handleErrors(err: NSError ,loginHandler:Loginhandler){
        
        if let errCode = AuthErrorCode(rawValue: err.code){
            
            switch errCode{
            case .userNotFound:
                loginHandler(loginErrorCode.USER_NOT_FOUND)
                break
            case .invalidEmail:
                loginHandler(loginErrorCode.INVALID_EMAIL)
                break
            case .invalidCustomToken:
                loginHandler(loginErrorCode.INVALID_CUSTOM_TOKEN)
                break
            case .customTokenMismatch:
                loginHandler(loginErrorCode.CUSTOM_TOKEN_MISMATCH)
                break
            case .invalidCredential:
                loginHandler(loginErrorCode.INVALID_CREDENTIAL)
                break
            case .userDisabled:
                loginHandler(loginErrorCode.USER_DISABLE)
                break
            case .operationNotAllowed:
                loginHandler(loginErrorCode.OPERATION_NOT_ALLOWED)
                break
            case .emailAlreadyInUse:
                loginHandler(loginErrorCode.EMAIL_ALREADY_USED)
                break
            case .wrongPassword:
                loginHandler(loginErrorCode.WRONG_PASSWORD)
                break
            case .tooManyRequests:
                loginHandler(loginErrorCode.TOO_MANY_REQUESTS)
                break
            case .accountExistsWithDifferentCredential:
                loginHandler(loginErrorCode.ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL)
                break
            case .requiresRecentLogin:
                loginHandler(loginErrorCode.REQUIRES_RECENT_LOGIN)
                break
            case .providerAlreadyLinked:
                loginHandler(loginErrorCode.PROVIDER_ALREADY_LINKED)
                break
            case .noSuchProvider:
                loginHandler(loginErrorCode.NO_SUCH_PROVIDER)
                break
            case .invalidUserToken:
                loginHandler(loginErrorCode.INVALID_USER_TOKEN)
                break
            case .networkError:
                loginHandler(loginErrorCode.NETWORK_ERROR)
                break
            case .userTokenExpired:
                loginHandler(loginErrorCode.USER_TOKEN_EXPIRED)
                break
            case .invalidAPIKey:
                loginHandler(loginErrorCode.INVALID_API_KEY)
                break
            case .userMismatch:
                loginHandler(loginErrorCode.USER_MISMATCH)
                break
            case .credentialAlreadyInUse:
                loginHandler(loginErrorCode.CREDENTIAL_ALREADY_IN_USE)
                break
            case .weakPassword:
                loginHandler(loginErrorCode.WEAK_PASSWORD)
                break
            case .appNotAuthorized:
                loginHandler(loginErrorCode.APP_NOT_AUTHORIZED)
                break
            case .expiredActionCode:
                loginHandler(loginErrorCode.EXPIRED_ACTION_CODE)
                break
            case .invalidActionCode:
                loginHandler(loginErrorCode.INVALID_ACTION_CODE)
                break
            case .invalidMessagePayload:
                loginHandler(loginErrorCode.INVALID_MESSAGE_PAYLOAD)
                break
            case .invalidSender:
                loginHandler(loginErrorCode.INVALID_SENDER)
                break
            case .invalidRecipientEmail:
                loginHandler(loginErrorCode.INVALID_RECIPIENT_EMAIL)
                break
            case .keychainError:
                loginHandler(loginErrorCode.KEYCHAIN_ERROR)
                break
            case .internalError:
                loginHandler(loginErrorCode.INTERNAL_ERROR)
                break
            default:
                loginHandler(loginErrorCode.SOMETHING_WENT_WRONG)
                break
            }
            
        }
    }//HandleError func
    
    //MARK:- registerUser
    class func registerUser(withName:String,email:String,password:String,profilePic:UIImage,fcmToken: String,notificationCount: Int,messageCount: Int,location: Dictionary<String, Any>,loginHandler: Loginhandler?){
        DispatchQueue.main.async {
            showLoader()
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil{
                user?.user.sendEmailVerification(completion: { (error) in
                    if error == nil{
                        let storageRef = Storage.storage().reference().child("usersProfilePics").child("\((Date().timeIntervalSince1970)).jpg")
                        let imageData = compressImage(image: profilePic)
                        storageRef.putData(imageData, metadata: nil, completion: { (metadata, err) in
                            if err == nil {
                                storageRef.downloadURL(completion: { (url, error) in
                                    if error == nil{
                                        guard let path = url?.absoluteString else{
                                            return
                                        }
                                        let values: [String: Any] = ["name": withName, "email": email, "profilePicLink": path,"location":location,"fcmToken":fcmToken,"notificationCount":notificationCount,"messageCount":messageCount]
                                        Database.database().reference().child("users").child((AppModel.shared.loggedInUser?.id)!).child("credentials").updateChildValues(values, withCompletionBlock: { (error, _) in
                                            if error == nil {
                                                DispatchQueue.main.async {
                                                    removeLoader()
                                                }
                                                //
                                                let userInfo = ["email" : email, "password" : password]
                                                UserDefaults.standard.set(AppModel.shared.loggedInUser?.id, forKey: "currentUser")
                                                UserDefaults.standard.set(userInfo, forKey: "userInformation")
                                                
                                                loginHandler!(nil)
                                                
                                                
                                            }
                                            else{
                                                DispatchQueue.main.async {
                                                    removeLoader()
                                                }
                                                
                                                
                                                self.handleErrors(err: error! as NSError, loginHandler: loginHandler!)
                                            }
                                        })
                                    }else{
                                        DispatchQueue.main.async {
                                            removeLoader()
                                        }
                                        
                                        self.handleErrors(err: error! as NSError, loginHandler: loginHandler!)
                                        
                                    }
                                })
                                
                            }
                        })
                    }
                    else{
                        self.handleErrors(err: error! as NSError, loginHandler: loginHandler!)
                    }
                })
                
                
            }
            else{
                DispatchQueue.main.async {
                    removeLoader()
                }
                
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler!)
                
            }
            
        }
    }//Register User
    
    
    //MARK:- loginUser
    class func loginUser(email: String, password: String, loginHandler: Loginhandler?) {
                DispatchQueue.main.async {
                     showLoader()
                }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            UserDefaults.standard.set(AppModel.shared.loggedInUser?.id, forKey: "currentUser")
            if error == nil {
                guard let status = Auth.auth().currentUser?.isEmailVerified else{
                    return
                }
                if status == true{
                    print("Logged In")
                    DispatchQueue.main.async {
                        removeLoader()
                    }
                    loginHandler!(nil)
                    
                }else{
                    removeLoader()
                    loginHandler!("Email is not verified")
                }
             
                
            } else {
                DispatchQueue.main.async {
                    removeLoader()
                }
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler!)
            }
        }
    }//Login User
    
    

    
    
    //MARK:- info
    class func info(forUserID: String, completion: @escaping (User) -> Swift.Void) {
           
        
        Database.database().reference().child("users").child(forUserID).child("credentials").observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any] {
                print(data)
                let name = data["name"] as? String
                let email = data["email"] as? String
                let location = data["location"] as? [String : Any]
                let latitude = location?["latitude"] as? String
                let longitude = location?["longitude"] as? String
                let pic = data["profilePicLink"] as? String
                let fcmToken = data["fcmToken"] as? String
                let user = User.init(name: name ?? "", email: email ?? "", id: forUserID, profilePic: pic ?? "", latitude: latitude ?? "", longitude: longitude ?? "",fcmToken: fcmToken ?? "")
                
                completion(user)
            }
        })
    }//Info
    
    
    class func checkUserVerification(completion: @escaping (Bool) -> Swift.Void) {
        Auth.auth().currentUser?.reload(completion: { (_) in
            let status = (Auth.auth().currentUser?.isEmailVerified)!
            completion(status)
        })
    }//Check user verification
    
    
    
}
