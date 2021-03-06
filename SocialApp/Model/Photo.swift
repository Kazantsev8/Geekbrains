//
//  Photo.swift
//  SocialApp
//
//  Created by Иван Казанцев on 03.03.2021.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Photo: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var type: String = "photo"
    @objc dynamic var owner_id: Int = 0
    @objc dynamic var urlSmallPhoto: String = ""
    @objc dynamic var urlPhotoX: String = ""
    @objc dynamic var urlBigPhoto: String = ""
    @objc dynamic var aspectRatio: Float = 0
    @objc dynamic var text: String = ""
    @objc dynamic var likes: Int = 0
    @objc dynamic var user_likes: Int = 0
    @objc dynamic var reposts: Int = 0
    var user = LinkingObjects(fromType: User.self, property: "images")
    
    convenience init (_ json:JSON){
        self.init()
        if json["id"].intValue != 0 {
            self.id = json["id"].intValue
            self.owner_id = json["owner_id"].intValue
            let sizes = json["sizes"].arrayValue
            if let photoX = sizes.first(where: { photo -> Bool in
                photo["type"].stringValue == "x"}){
                self.urlPhotoX = photoX["url"].stringValue
            }
            let biggestSize = sizes.reduce(sizes[0]) {currentSize, newSize -> JSON in
                let currentPoints = currentSize["width"].intValue + currentSize["height"].intValue
                let newPoints = newSize["width"].intValue + newSize["height"].intValue
                return currentPoints >= newPoints ? currentSize : newSize
            }
            
            self.urlSmallPhoto = sizes[0]["url"].stringValue
            self.urlBigPhoto = biggestSize["url"].stringValue
            var aspectRatio: Float {
                let height = sizes[0]["height"].floatValue
                let width = sizes[0]["width"].floatValue
                return height/width
            }
            self.aspectRatio = aspectRatio
            self.text = json["text"].stringValue
            self.likes = json["likes"]["count"].intValue
            self.user_likes = json["likes"]["user_likes"].intValue
            self.reposts = json["reposts"]["count"].intValue
            
        } else {
            self.id = json["photo"]["id"].intValue
            self.owner_id = json["photo"]["owner_id"].intValue
            let sizes = json["photo"]["sizes"].arrayValue
            if let photoX = sizes.first(where: { photo -> Bool in
                photo["type"].stringValue == "x"}){
                self.urlPhotoX = photoX["url"].stringValue
            }
            let biggestSize = sizes.reduce(sizes.first) {currentSize, newSize -> JSON in
                guard let curSize = currentSize else {preconditionFailure("currentSize - nil")}
                let currentPoints = curSize["width"].intValue + curSize["height"].intValue
                let newPoints = newSize["width"].intValue + newSize["height"].intValue
                return currentPoints >= newPoints ? curSize : newSize
            }
            guard let bigSize = biggestSize else {preconditionFailure("biggestSize - nil")}
            self.urlSmallPhoto = sizes[2]["url"].stringValue
            self.urlBigPhoto = bigSize["url"].stringValue
            var aspectRatio: Float {
                let height = sizes[0]["height"].floatValue
                let width = sizes[0]["width"].floatValue
                return height/width
            }
            self.aspectRatio = aspectRatio
            self.text = json["photo"]["text"].stringValue
            self.likes = json["photo"]["likes"]["count"].intValue
            self.user_likes = json["photo"]["likes"]["user_likes"].intValue
            self.reposts = json["photo"]["reposts"]["count"].intValue
        }
        
    }
    
    convenience init (_ string: String, json:JSON){
        self.init()
        self.id = json["id"].intValue
        self.owner_id = json["owner_id"].intValue
        let sizes = json["sizes"].arrayValue
        if let photoX = sizes.first(where: { photo -> Bool in
            photo["type"].stringValue == "x"}){
            self.urlPhotoX = photoX["url"].stringValue
        }
        let biggestSize = sizes.reduce(sizes[0]) {currentSize, newSize -> JSON in
            let currentPoints = currentSize["width"].intValue + currentSize["height"].intValue
            let newPoints = newSize["width"].intValue + newSize["height"].intValue
            return currentPoints >= newPoints ? currentSize : newSize
        }
        self.urlSmallPhoto = sizes[0]["url"].stringValue
        self.urlBigPhoto = biggestSize["url"].stringValue
        self.text = json["text"].stringValue
        self.likes = json["likes"]["count"].intValue
        self.user_likes = json["likes"]["user_likes"].intValue
        self.reposts = json["reposts"]["count"].intValue
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
