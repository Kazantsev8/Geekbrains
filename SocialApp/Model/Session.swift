//
//  Session.swift
//  SocialApp
//
//  Created by Иван Казанцев on 26.02.2021.
//

import Foundation

class AppSession {
    static let instance = AppSession()
    var token: String?
    var userId: String?
    
    private init(){}
}

