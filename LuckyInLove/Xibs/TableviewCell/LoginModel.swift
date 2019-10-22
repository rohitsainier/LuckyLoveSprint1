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
    let loginUserDetails: LoginUserDetails?
    let userGallary: UserGallary?
    

    enum CodingKeys: String, CodingKey {
        case error, message, loginUserDetails
        case userGallary = "user_gallary"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(Bool.self, forKey: .error) ?? false
        message  = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        loginUserDetails = try values.decodeIfPresent(LoginUserDetails.self, forKey: .loginUserDetails) ?? nil
        userGallary = try values.decodeIfPresent(UserGallary.self, forKey: .userGallary) ?? nil
       
    }
    
    
    
}

// MARK: - LoginUserDetails
struct LoginUserDetails: Codable {
    let userPic: UserPic?
    let id, fname, lname: String
    let username: String
    let email, password: String
    let profileImage: String
    let about: String
    let gender, profession: String
    let country, locationLat, locationLong: String
    let genderPref, maxAgePref, minAgePref, maxDistPref: String
    let minDistPref: String
    let authToken: String

    enum CodingKeys: String, CodingKey {
        case userPic = "1"
        case id, fname, lname, username, email, password
        case profileImage = "profile_image"
        case about, gender, profession, country
        case locationLat = "location_lat"
        case locationLong = "location_long"
        case genderPref = "gender_pref"
        case maxAgePref = "max_age_pref"
        case minAgePref = "min_age_pref"
        case maxDistPref = "max_dist_pref"
        case minDistPref = "min_dist_pref"
        case authToken = "AuthToken"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        fname  = try values.decodeIfPresent(String.self, forKey: .fname) ?? ""
        lname = try values.decodeIfPresent(String.self, forKey: .lname) ?? ""
        username = try values.decodeIfPresent(String.self, forKey: .username) ?? ""
        email = try values.decodeIfPresent(String.self, forKey: .email) ?? ""
        password = try values.decodeIfPresent(String.self, forKey: .password) ?? ""
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage) ?? ""
        //age = try values.decodeIfPresent(Int.self, forKey: .age) ?? 0
        about = try values.decodeIfPresent(String.self, forKey: .about) ?? ""
        gender = try values.decodeIfPresent(String.self, forKey: .gender) ?? ""
        profession = try values.decodeIfPresent(String.self, forKey: .profession) ?? ""
        country = try values.decodeIfPresent(String.self, forKey: .country) ?? ""
        genderPref = try values.decodeIfPresent(String.self, forKey: .genderPref) ?? ""
        maxAgePref = try values.decodeIfPresent(String.self, forKey: .maxAgePref) ?? ""
        
        minAgePref = try values.decodeIfPresent(String.self, forKey: .minAgePref) ?? ""
        maxDistPref = try values.decodeIfPresent(String.self, forKey: .maxDistPref) ?? ""
        minDistPref = try values.decodeIfPresent(String.self, forKey: .minDistPref) ?? ""
        locationLat = try values.decodeIfPresent(String.self, forKey: .locationLat) ?? ""
        locationLong = try values.decodeIfPresent(String.self, forKey: .locationLong) ?? ""
        authToken = try values.decodeIfPresent(String.self, forKey: .authToken) ?? ""
        userPic = try values.decodeIfPresent(UserPic.self, forKey: .userPic) ?? nil
    }
}

// MARK: - UserGallary
struct UserGallary: Codable {
    let img1: String
}

// MARK: - The1
struct UserPic: Codable {
    let img2: String
}

// MARK: - UserListModel
struct UserListModel: Codable {
    let error: Bool
    let message: String
    let users: [LoginUserDetails]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(Bool.self, forKey: .error) ?? false
        message  = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        users = try values.decodeIfPresent([LoginUserDetails].self, forKey: .users) ?? []
    }
    
    
}

