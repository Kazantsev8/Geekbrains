//
//  NewsTopCell.swift
//  SocialApp
//
//  Created by Иван Казанцев on 06.04.2021.
//

import UIKit
import RealmSwift

class NewsTopCell: UITableViewCell {

    @IBOutlet var avatar: UserAvatarImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var date: UILabel!

    
    public func configureNewsTop(with news: News?) {
        guard var sourceId = news?.sourceId else {return}
        var avatarUrl: String = ""
        var sourceName: String = ""
        var postDate: Date = Date.distantPast
        guard sourceId != 0 else {return}
        if sourceId > 0 {
            guard let news = news,
                let sourceDB = try? Realm().objects(User.self).filter("id == %@", sourceId),
                let user = sourceDB.first
                else {return}
            avatarUrl = user.avatar
            sourceName = (user.firstName+" "+user.lastName)
            postDate = Date(timeIntervalSince1970: news.date)
        } else {
            sourceId = -sourceId
            guard let news = news,
                let sourceDB = try? Realm().objects(Group.self).filter("id == %@", sourceId),
                let group = sourceDB.first
                else {return}
            avatarUrl = group.avatar
            sourceName = group.name
            postDate = Date(timeIntervalSince1970: news.date)
        }
        avatar.kf.setImage(with: URL(string: avatarUrl))
        name.text = sourceName
        date.text = postDate.toString(dateFormat: "HH:mm dd-MM-yy")
    }

    
}
