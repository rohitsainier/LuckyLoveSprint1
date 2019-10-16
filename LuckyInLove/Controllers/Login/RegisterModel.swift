//
//  RegisterModel.swift
//  LuckyInLove
//
//  Created by Rohit Saini on 16/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import Foundation
// MARK: - RegisterModel
struct RegisterModel: Codable {
    let error: Bool
    let message: String
    let body: Body?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(Bool.self, forKey: .error) ?? false
        message  = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        body = try values.decodeIfPresent(Body.self, forKey: .body) ?? nil
       
    }
}

// MARK: - Body
struct Body: Codable {
    let id, fname, lname, username: String
    let email, password, profileImage, age: String
    let about, gender, profession, country: String
    let genderPref, maxAgePref, minAgePref, maxDistPref: String
    let minDistPref, locationLat, locationLong, authToken: String

    enum CodingKeys: String, CodingKey {
        case id, fname, lname, username, email, password
        case profileImage = "profile_image"
        case age, about, gender, profession, country
        case genderPref = "gender_pref"
        case maxAgePref = "max_age_pref"
        case minAgePref = "min_age_pref"
        case maxDistPref = "max_dist_pref"
        case minDistPref = "min_dist_pref"
        case locationLat = "location_lat"
        case locationLong = "location_long"
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
        age = try values.decodeIfPresent(String.self, forKey: .age) ?? ""
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
    }
    
}


// MARK: - UploadPictureModel
struct UploadPictureModel: Codable {
    let gallary: Gallary?
    let error: Bool
    let message: String
    
    init(from decoder: Decoder) throws {
           let values = try decoder.container(keyedBy: CodingKeys.self)
           gallary = try values.decodeIfPresent(Gallary.self, forKey: .gallary) ?? nil
           error  = try values.decodeIfPresent(Bool.self, forKey: .error) ?? false
           message  = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
           
    }
}

// MARK: - Gallary
struct Gallary: Codable {
    let img1: String
    init(from decoder: Decoder) throws {
           let values = try decoder.container(keyedBy: CodingKeys.self)
           img1 = try values.decodeIfPresent(String.self, forKey: .img1) ?? ""
    }
}
