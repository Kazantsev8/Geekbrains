//
//  NewsImageCell.swift
//  SocialApp
//
//  Created by Иван Казанцев on 06.04.2021.
//

import UIKit
import Kingfisher

class NewsImageCell: UITableViewCell {

    var newsImage: UIImageView = {
        let newsImage = UIImageView()
        newsImage.contentMode = .scaleAspectFit
        newsImage.kf.indicatorType = .activity
        return newsImage
    }()
    
    private var height: CGFloat = .greatestFiniteMagnitude
    private let offset: CGFloat = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    private func setupSubviews(){
        setupImage()
        addSubview(newsImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupImage()
    }
    
    private func setupImage(){
        newsImage.frame = CGRect (x: offset, y: offset, width: bounds.width-(offset*2), height: height-(offset*2))
    }
    
    func configureImageCell (with news: News){
        if let image = news.photoAttachments.first{
            self.height = (bounds.width * CGFloat(image.aspectRatio)).rounded(.up)
            newsImage.kf.setImage(with: URL(string: image.urlPhotoX))
        } else if news.gifUrl != "" {
            self.height = (bounds.width * CGFloat(news.gifAspectRatio)).rounded(.up)
            newsImage.kf.setImage(with: URL(string: news.gifUrl))
        }
    }
}

