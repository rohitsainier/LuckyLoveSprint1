//
//  AppModel.swift
//  LuckyInLove
//
//  Created by Rohit Saini on 13/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//


import UIKit

//MARK: - AppModel
class AppModel: NSObject {
    static let shared = AppModel()
    var token = ""
    var loggedInUser: DummyUser!
    
}

struct DummyUser {
    var id: String
}
