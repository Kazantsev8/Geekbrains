//
//  UserGroupCell.swift
//  SocialApp
//
//  Created by Иван Казанцев on 17.01.2021.
//

import UIKit

class UserGroupCell: UITableViewCell {
    
    @IBOutlet weak var userGroupNameLabel: UILabel!
    @IBOutlet weak var userGroupAvatarImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        userGroupAvatarImage?.layer.cornerRadius = 30
        userGroupAvatarImage?.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        
        userGroupAvatarImage.addGestureRecognizer(tapGesture)
        userGroupAvatarImage.isUserInteractionEnabled = true
    }
    
    @objc func onTap(_ sender: UIGestureRecognizer) {
        print(#function)
        
        
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       animations: {
                        self.userGroupAvatarImage.transform = .init(scaleX: 0.9, y: 0.9)
        })
        
        UIView.animate(withDuration: 1,
                       delay: 0.2,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 30,
                       animations: {
                        self.userGroupAvatarImage.transform = .init(scaleX: 1, y: 1)
        })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
