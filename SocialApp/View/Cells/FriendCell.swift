//
//  FriendCell.swift
//  SocialApp
//
//  Created by Иван Казанцев on 28.03.2021.
//

import UIKit
import Kingfisher

class FriendCell: UITableViewCell {

    public let avatar = UserAvatarImageView()
    public let name = UILabel()
    private let backShadow = UserAvatarShadowView()
    private let height: CGFloat = 90
    private let insetBackShadow: CGFloat = 10
    private let insetLabel: CGFloat = 15
    
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
    
    private func setupSubviews() {
        addSubview(backShadow)
        backShadow.addSubview(avatar)
        addSubview(name)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupBackShadow()
        setupAvatar()
        setupName()
    }
    
    private func setupBackShadow() {
        let size = CGSize (width: height, height: height)
        let origin = CGPoint (x: (insetBackShadow), y: (bounds.height - height)/2)
        backShadow.frame = CGRect (origin: origin, size: size)
    }
    
    private func setupAvatar() {
        avatar.frame = backShadow.bounds
        avatar.contentMode = .scaleAspectFit
    }
    
    private func setupName() {
        let size = getLabelSize(text: name.text ?? "", font: name.font)
        let origin = CGPoint(x: (backShadow.bounds.width + insetBackShadow + insetLabel), y: (bounds.height - size.height)/2)
        name.frame = CGRect(origin: origin, size: size)
    }
    
    private func getLabelSize(text: String, font: UIFont) -> CGSize {
        let maxWidth = contentView.bounds.width - backShadow.bounds.width - insetBackShadow - (insetLabel*2)
        let textblock = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
        
        let rect = text.boundingRect(with: textblock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
        
        let width = rect.width.rounded(.up)
        let height = rect.height.rounded(.up)
        return CGSize(width: width, height: height)
    }

    public func configureGroup(with group: Group?) {
        guard let group = group else {return}
        name.text = group.name
        avatar.kf.setImage(with: URL(string: group.avatar))
    }
    
    public func configureUser(with user: User?){
        guard let user = user else {return}
        name.text = user.firstName + " " + user.lastName
        avatar.kf.setImage(with: URL(string: user.avatar))
    }


}
