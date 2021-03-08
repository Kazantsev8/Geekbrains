//
//  NewsTableViewCell.swift
//  SocialApp
//
//  Created by Иван Казанцев on 08.02.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsAuthorAvatar: UIImageView!
    @IBOutlet weak var newsAuthorNameLabel: UILabel!
    @IBOutlet weak var newsTextView: UITextView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsLikeControl: Like!
    @IBOutlet weak var newsCommentControl: Comment!
    @IBOutlet weak var newsRepostControl: Repost!
    @IBOutlet weak var newsWatchControl: Watch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
