//
//  Constants.swift
//  PatientDocSmart
//
//  Created by DocSmart on 27/12/18.
//  Copyright © 2018 DocSmart. All rights reserved.
//

import UIKit
import Foundation


// STORYBOARD
struct STORYBOARD {
    static var MAIN = UIStoryboard(name: "Main", bundle: nil)
    static var EXPLORE = UIStoryboard(name: "Explore", bundle: nil)
    static var MATCHES = UIStoryboard(name: "Matches", bundle: nil)
    static var CHAT = UIStoryboard(name: "Chat", bundle: nil)
    static var PROFILE = UIStoryboard(name: "Profile", bundle: nil)
}

//iPhone Screensize
struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

//iPhone devicetype
struct DeviceType {
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONE_XR         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
    static let IS_IPHONE_XS         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONE_XSM        = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
}

//MARK:- Alert Constants
// Alert Button Title
struct AlertButtonTitle {
    static let kOK                                      = "OK"
    static let kCancel                                  = "Cancel"
    static let kDone                                    = "Done"
    static let kAgree                                   = "Agree"

}

//MARK:- Simple Button Title
struct ButtonTitle {
    static let kStartSession                            = "Start Session"
    static let kEndSession                              = "End Session"
}

// Alert Messages
struct AlertMessages {
    static let kEmailValidate                           = "Please enter valid email"

}

//MARK:- Identifires

// Storyboard Identifires
struct StroyBoardIdentifire {
    static let kMain                                    = "Main"
    

}

//View Controllers Identifires
struct ControllerIdentifire {
    static let kSignupVC                        = "SignupVC"
    static let kExploreVC                       = "ExploreVC"
    static let kMatchesVC                       = "MatchesVC"
    static let kChatListingVC                   = "ChatListingVC"
    static let kProfileVC                       = "ProfileVC"
}


//TableView Cell Identifires
struct TableViewCellIdentifire {
    static let kChatListingCell                 = "ChatListingCell"

}

//CollectionView Cell Identifires
struct CollectionViewCellIdentifire {
    static let kMatchesCell                     = "MatchesCell"
}

struct TableViewEmptyMessage {
}

//Corner Radius config
struct CornerRadius {
    static let kButtonCornerRadius                       = 8.0
}

struct BorderWidth {
    static let kZeroPxBorder                            = 0.0
    static let kOnePxBorder                             = 1.0
    static let kTwoPxBorder                             = 2.0
    static let kThreePxBorder                           = 3.0
    static let kFourPxBorder                            = 4.0
    static let kFivePxBorder                            = 5.0
    static let kSixPxBorder                             = 6.0
    static let kSevenPxBorder                           = 7.0
    static let kEightPxBorder                           = 8.0
    static let kNinePxBorder                            = 9.0
}

//Tab bar
struct tabbarData {
    static let arrTabBarData = [["title":"Search","defaultImage":"search","selectedImage":"dashboard_selected","backgroundColor":UIColor.clear],["title":"DashBoard","defaultImage":"dashboard","selectedImage":"search_selected","backgroundColor":UIColor.clear],["title":"Notification","defaultImage":"notification","selectedImage":"notification_selected","backgroundColor":UIColor.clear]]
}

//MARK:- Color Constants configure

struct color {
    
}



struct  ServerAPI {
    static let deviceType = "ios"
    static let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    
    struct URL {}
    
    struct APIKeys {
        
    }
    
    struct APIKeyValue {
    }
    
    struct ErrorMessages {
        static let kNoInternetConnectionMessage     = "Please check your internet connection."
        static let kCommanErrorMessage              = "Something went wrong. Please try again later."
    }
    struct userDefaultKeys {
        static let kDeviceTokenKey                      = "DeviceToken"
        
    }
}

//MARK:- User Default Keys

struct UserDefaultsKey {
    static let kIsLoggedIn                    = "isLoggedIn"
    static let kLoginUser                     = "loginUser"
    static let kToken                         = "token"
    static let kuserid                        = "userid"
    static let kUserRole                      = "userRole"
    static let kLoginFlow                     = "loginFlow"
}

//MARK:- Date & Time Formate

struct DateTimeFormat {
    static let kMMMDateTime                 = "MMM dd, yyyy  hh:mm a"
    static let kDateTime                    = "dd-MM-yyyy hh:mm a"
    static let kDate                        = "dd-MM-yyyy"
    static let kTime                        = "hh:mm a"
    static let kAM                          = "AM"
    static let kPM                          = "PM"
}



// MARK: - Common Request/Response API Parameter Constant
let kAuthorization = "Authorization"
let kPageNo = "pageNo"
let kpageNumber = "pageNumber"
let kpageSize  = "pageSize"
let kIsSuccess = "status"
//let kMessage = "Message"
let kData = "data"
let kTotalCount = "TotalCount"
let kZOOM_SCALE = CGFloat(2)
let kGoogleServicesApiKey = "AIzaSyBjGxptDMgl7Ftei3mo5hC5_sj7dCVA0RU"
let kGooglePlaceAPIKey = "AIzaSyBjGxptDMgl7Ftei3mo5hC5_sj7dCVA0RU"
let kflag = "flag"
let kgivenRatings = "givenRatings"
let kreceivedRatings = "receivedRatings"
let kGoogleDistanceKey = "AIzaSyCmrEHYH1sC21bjQlPsUQFNAOcRYB2aiI0"

