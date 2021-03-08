//
//  GeneralGroupCell.swift
//  SocialApp
//
//  Created by Иван Казанцев on 17.01.2021.
//

import UIKit

class GeneralGroupCell: UITableViewCell {
    
    @IBOutlet weak var generalGroupNameLabel: UILabel!
    @IBOutlet weak var generalGroupAvatarImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        generalGroupAvatarImage?.layer.cornerRadius = 30
        generalGroupAvatarImage?.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        
        generalGroupAvatarImage.addGestureRecognizer(tapGesture)
        generalGroupAvatarImage.isUserInteractionEnabled = true
    }
    
    @objc func onTap(_ sender: UIGestureRecognizer) {
        print(#function)
        
        
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       animations: {
                        self.generalGroupAvatarImage.transform = .init(scaleX: 0.9, y: 0.9)
        })
        
        UIView.animate(withDuration: 1,
                       delay: 0.2,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 30,
                       animations: {
                        self.generalGroupAvatarImage.transform = .init(scaleX: 1, y: 1)
        })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
