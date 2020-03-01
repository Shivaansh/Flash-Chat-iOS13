//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Shivaansh Prasann on 2020-02-28.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation

struct K {
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "regToChat"
    static let loginSegue = "loginToChat"
    static let appTitle = "⚡️TrashChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lightBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
