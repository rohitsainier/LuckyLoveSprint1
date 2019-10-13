//
//  LoginModel.swift
//  LuckyInLove
//
//  Created by Rohit Saini on 13/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//


// MARK: - LoginModel
struct LoginModel: Codable {
    let error: Bool
    let message: String
    let loginUserDetails: LoginUserDetails
    let userGallary: UserGallary
    

    enum CodingKeys: String, CodingKey {
        case error, message, loginUserDetails
        case userGallary = "user_gallary"
    }
    
    
}

// MARK: - LoginUserDetails
struct LoginUserDetails: Codable {
    let id, fname, lname: String
    let username: String
    let email, password: String
    let profileImage: String
    let fbID, dob, age, about: String
    let gender, education, profession, religion: String
    let height: String
    let kids, address: String
    let country, locationLat, locationLong, datePref: String
    let genderPref, maxAgePref, minAgePref, maxDistPref: String
    let minDistPref, ethnicity, queID: String
    let queAns, accessLocation: String
    let status, isAdmin, isDeleted, isConfirmed: String
    let createdDate, modifiedDate, notificationcounter, enableAdd: String
    let ejuser: String
    let passToken, passCode, ethnicityPref, religionPref: String
    let sampledata, authToken: String

    enum CodingKeys: String, CodingKey {
        case id, fname, lname, username, email, password
        case profileImage = "profile_image"
        case fbID = "fb_id"
        case dob, age, about, gender, education, profession, religion, height, kids, address, country
        case locationLat = "location_lat"
        case locationLong = "location_long"
        case datePref = "date_pref"
        case genderPref = "gender_pref"
        case maxAgePref = "max_age_pref"
        case minAgePref = "min_age_pref"
        case maxDistPref = "max_dist_pref"
        case minDistPref = "min_dist_pref"
        case ethnicity
        case queID = "que_id"
        case queAns = "que_ans"
        case accessLocation = "access_location"
        case status
        case isAdmin = "is_admin"
        case isDeleted = "is_deleted"
        case isConfirmed = "is_confirmed"
        case createdDate = "created_date"
        case modifiedDate = "modified_date"
        case notificationcounter, enableAdd, ejuser
        case passToken = "pass_token"
        case passCode = "pass_code"
        case ethnicityPref = "ethnicity_pref"
        case religionPref = "religion_pref"
        case sampledata
        case authToken = "AuthToken"
    }
}

// MARK: - UserGallary
struct UserGallary: Codable {
    let img1: String
}
