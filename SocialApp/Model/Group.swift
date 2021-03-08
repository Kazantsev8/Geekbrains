//
//  Group.swift
//  SocialApp
//
//  Created by Иван Казанцев on 19.01.2021.
//

import UIKit
import SwiftyJSON
import RealmSwift

class Group: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var avatar: String = ""
    
    convenience init(_ json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.avatar = json["photo_200"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
