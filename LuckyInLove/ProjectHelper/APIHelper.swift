//
//  APIHelper.swift
//  LuckyInLove
//
//  Created by Rohit Saini on 13/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import Foundation
import UIKit



struct API {
    static var BASE_URL = "http://ec2-18-191-227-23.us-east-2.compute.amazonaws.com/webserverluckyinlove/Api/"
   
    
    
    //API's
    //User API
    struct USER {
        static let Login = BASE_URL + "login"
        static let Register = BASE_URL + "register"
        static let UserListing = BASE_URL + "getUsers"
        static let UserDetails = BASE_URL + "getSingleUserData"
    }
    
    
}

//MARK:- GCD
//MultiThreading
struct GCD{
    struct USER {
        static let LOGIN = DispatchQueue(label: "com.app.LOGIN", qos: DispatchQoS.userInteractive, attributes: DispatchQueue.Attributes.concurrent)//1
        
        static let REGISTER = DispatchQueue(label: "com.app.REGISTER", qos: DispatchQoS.background, attributes: DispatchQueue.Attributes.concurrent)//2
        
         static let USER_DETAILS = DispatchQueue(label: "com.app.USER_DETAILS", qos: DispatchQoS.userInteractive, attributes: DispatchQueue.Attributes.concurrent)//3
        
        static let USER_LISTING = DispatchQueue(label: "com.app.USER_LISTING", qos: DispatchQoS.userInteractive, attributes: DispatchQueue.Attributes.concurrent)//4
    }
}
