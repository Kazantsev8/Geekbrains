//
//  UserAvatarImageView.swift
//  SocialApp
//
//  Created by Иван Казанцев on 26.03.2021.
//

import UIKit

class UserAvatarImageView: UIImageView {

    let borderColor: UIColor = .gray
    let borderWidth: CGFloat = 1.5
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor

    }
    
}
