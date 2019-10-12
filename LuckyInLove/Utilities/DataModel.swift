//
//  DataModel.swift
//  LuckyInLove
//
//  Created by Ruchit on 05/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    
    static let sharedInstance = DataModel()
    
    //MARK: Set device token
    func onSetUserDeviceToken(dToken : String) {
        UserDefaults.standard.setValue(dToken, forKey: ServerAPI.userDefaultKeys.kDeviceTokenKey)
        UserDefaults.standard.synchronize()
    }
    
    //MARK: Get device token
    func onFetchDeviceToken() -> String {
        let deviceTokenStr = UserDefaults.standard.value(forKey: ServerAPI.userDefaultKeys.kDeviceTokenKey) as? String
        return deviceTokenStr ?? ""
    }
    
    //MARK: Load data in active user
    
    //MARK: Set token
    func onSetToken(dToken : String) {
        UserDefaults.standard.setValue(dToken, forKey: UserDefaultsKey.kToken)
        UserDefaults.standard.synchronize()
    }
    
    //MARK: Get token
    func onFetchToken() -> String {
        let deviceTokenStr = UserDefaults.standard.value(forKey: UserDefaultsKey.kToken) as? String
        
        return deviceTokenStr ?? ""
    }
    
    //MARK: Set Userid
    func onSetuserId(uid : String) {
        UserDefaults.standard.setValue(uid, forKey: UserDefaultsKey.kuserid)
        UserDefaults.standard.synchronize()
    }
    
    //MARK: Get token
    func onFetchUserId() -> String {
        let userIdStr = UserDefaults.standard.value(forKey: UserDefaultsKey.kuserid) as? String
        
        return userIdStr ?? ""
    }
    
    
    //MARK: Set Login Flow
    func onSetLoginFlow(uid : String) {
        UserDefaults.standard.setValue(uid, forKey: UserDefaultsKey.kLoginFlow)
        UserDefaults.standard.synchronize()
    }
    
    //MARK: Get token
    func onFetchLoginFlow() -> String {
        let userIdStr = UserDefaults.standard.value(forKey: UserDefaultsKey.kLoginFlow) as? String
        
        return userIdStr ?? ""
    }
    
    //MARK: Set Userid
    func onSetuserRole(userRoleStr : String) {
        UserDefaults.standard.setValue(userRoleStr, forKey: UserDefaultsKey.kUserRole)
        UserDefaults.standard.synchronize()
    }
    
    //MARK: Get token
    func onFetchUserRole() -> String {
        let userRoleStr = UserDefaults.standard.value(forKey: UserDefaultsKey.kUserRole) as? String
        
        return userRoleStr ?? ""
    }
    
    //MARK:Store data to user default
    func storeInDefault(object:Any,key:String)  {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: object)
        userDefaults.set(encodedData, forKey: key)
        userDefaults.synchronize()
    }
    
    //MARK:Retrieve data to user default
    func retrieveFromDefault(key:String) ->  AnyObject? {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.object(forKey: key) {
            let object = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
            return object as AnyObject
        }else{
            //print("There is an issue")
            return nil
        }
    }
    
    func removeFromDefault(key: String)
    {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: key)
        userDefaults.synchronize()
    }
    
}
