//
//  NewsBottomCell.swift
//  SocialApp
//
//  Created by Иван Казанцев on 06.04.2021.
//

import UIKit

class NewsBottomCell: UITableViewCell {

    @IBOutlet var heart: UIImageView!
    @IBOutlet var likeCount: UILabel!
    @IBOutlet var repostCount: UILabel!
    @IBOutlet var viewsCount: UILabel!
    @IBOutlet var commentCount: UILabel!
    
    public func configureNewsBottom(with news: News?) {
        guard let news = news else {return}
        if news.userLike == 1 {
            heart.image = UIImage(named: "heart_filled")
        }
        likeCount.text = String(news.likesCount)
        repostCount.text = String(news.repostsCount)
        viewsCount.text = String(news.views)
        commentCount.text = String(news.commentsCount)
    }

}
