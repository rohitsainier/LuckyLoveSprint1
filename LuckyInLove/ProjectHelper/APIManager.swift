//
//  APIManager.swift
//  LuckyInLove
//
//  Created by Rohit Saini on 13/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import Foundation
import SystemConfiguration
import Alamofire
import NVActivityIndicatorView

public class APIManager {
    
    static let sharedInstance = APIManager()
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func getMultipartHeader() -> [String:String]{
        return ["Content-Type":"multipart/form-data"]
    }
    
    func getJsonHeader() -> [String:String]{
        return ["Content-Type":"application/json"]
    }
    
    func getJsonHeaderWithToken() -> [String:String]{
        return ["Content-Type":"application/json", "Authorization":AppModel.shared.token]
    }

    func getMultipartHeaderWithToken() -> [String:String]{
        return ["Content-Type":"multipart/form-data", "Authorization":AppModel.shared.token]
    }


    func getx_www_orm_urlencoded() -> [String:String]{
        return ["Content-Type":"x-www-form-urlencoded", "Authorization":AppModel.shared.token]
    }

    func networkErrorMsg()
    {
        displayToast("You are not connected to the internet")
    }

    //MARK:- ERROR CODES
    func handleError(errorCode: Int) -> String {
        switch errorCode {
        case 101:
            return "Missing Required Properties"
        case 102:
            return "Connection Error"
        case 103:
            return "Requested user not found"
        case 104:
            return "Username/Password error"
        case 105:
            return "Nothing Modified/ No changes Made"
        case 106:
            return "Invalid Access Token"
        case 107:
            return "This Email id is already registered."
        case 108:
            return "Invalid OTP type."
        case 109:
            return "Token not verified."
        case 110:
            return "Email id already verified."
        case 111:
            return "Verficiation code try has been expired. Request a new token."
        case 112:
            return "verification code has been expired. Token expires in 24 hours."
        case 113:
            return "Invlid URL provided for verification."
        case 114:
            return "Broken reference found."
        case 115:
            return "Profile seems to have missing region data or you are trying to post in wrong region."
        case 400:
            return "Malformed Authorization token error when token in invalid or has been expired."
        case 500:
            return "Generic error or some default error"
            
        default:
            return ""
        }
        
    }

    //MARK:- MULTIPART_IS_COOL
    func MULTIPART_IS_COOL(_ imageData : Data,param: [String: Any],api: String,login: Bool, _ completion: @escaping (_ dictArr: Data?) -> Void){
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }

        DispatchQueue.main.async {
            showLoader()
        }
        var headerParams :[String : String] = [String : String]()
        if login == true{
            headerParams = getMultipartHeaderWithToken()
        }
        else{
            headerParams = getMultipartHeader()
        }
        var params :[String : Any] = [String : Any] ()

        params["data"] = toJson(param) //Converting Array into JSON Object
        print(params)

        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            if imageData.count != 0
            {
                multipartFormData.append(imageData, withName: "image", fileName: getCurrentTimeStampValue() + ".png", mimeType: "image/png")
            }
        }, usingThreshold: UInt64.init(), to: api, method: .post
        , headers: headerParams) { (result) in
            switch result{
            case .success(let upload, _, _):

                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                upload.responseJSON { response in

                    DispatchQueue.main.async {
                        removeLoader()
                    }

                    print(response.result.value!)
                    if let result = response.result.value as? [String:Any]{
                        if let code = result["code"] as? Int{
                            if(code == 100){

                                DispatchQueue.main.async {
                                    completion(response.data)
                                }
                                return
                            }
                            else{
                                DispatchQueue.main.async {
                                    completion(response.data)
                                }
                                if let message = result["message"] as? String{
                                    displayToast(message)
                                }
                                return
                            }
                        }
                        if let message = result["message"] as? String{
                            displayToast(message)
                            return
                        }
                    }
                    if let error = response.result.error
                    {
                        displayToast(error.localizedDescription)
                        return
                    }
                    displayToast("error")

                }

            case .failure(let error):

                print(error)
                displayToast("Server Error please check server logs.")
                break
            }
        }
    }

    

    //MARK:- I AM COOL
    func I_AM_COOL(params: [String: Any],api: String,Loader: Bool,isMultipart:Bool,_ completion: @escaping (_ dictArr: Data?) -> Void){
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }

        if Loader == true{
        DispatchQueue.main.async {
            showLoader()
        }
        }

        var headerParams :[String : String] = [String: String]()
        var Params:[String: Any] = [String: Any]()
        if isMultipart == true{
             headerParams = getMultipartHeaderWithToken()
             Params["data"] = toJson(params)
        }
        else{
             headerParams  = getJsonHeaderWithToken()
             Params = params
        }
        print(headerParams)
        print(Params)
        print(api)

        Alamofire.request(api, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headerParams).responseJSON { (response) in

            DispatchQueue.main.async {
                removeLoader()
            }

            switch response.result {
            case .success:
                print(response.result.value ?? "No data availabe")
                if let result = response.result.value as? [String:Any]{
                    if let code = result["code"] as? Int{
                        if(code == 100){

                            DispatchQueue.main.async {
                                completion(response.data)
                            }
                            return
                        }
                        else{
                            DispatchQueue.main.async {
                                completion(response.data)
                            }
                            if let message = result["message"] as? String{
                                DispatchQueue.main.async {
                                    displayToast(message)
                                }
                                
                            }
                            return
                        }
                    }
                    if let message = result["message"] as? String{
                        DispatchQueue.main.async {
                            displayToast(message)
                        }
                        return
                    }
                }
                if let error = response.result.error
                {
                    DispatchQueue.main.async {
                        displayToast(error.localizedDescription)
                    }
                    return
                }
                displayToast("error")
                break
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    completion(response.data)
                }
                displayToast("Server Error please check server logs.")
                break
            }
        }
    }
}
