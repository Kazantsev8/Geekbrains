//
//  User.swift
//  SocialApp
//
//  Created by Иван Казанцев on 19.01.2021.
//

import UIKit
import SwiftyJSON
import RealmSwift

class User: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var avatar: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var is_friend: Int = 0
    let images = List<Photo>()
    let groups = List<Group>()
    
    convenience init(_ json: JSON, images: [Photo] = [], groups : [Group] = []) {
            self.init()
            self.id = json["id"].intValue
            self.avatar = json["photo_200"].stringValue
            self.firstName = json["first_name"].stringValue
            self.lastName = json["last_name"].stringValue
            self.is_friend = json["is_friend"].intValue
            self.groups.append(objectsIn: groups)
        }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
