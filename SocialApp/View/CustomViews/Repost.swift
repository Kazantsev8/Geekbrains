//
//  Repost.swift
//  SocialApp
//
//  Created by Иван Казанцев on 02.03.2021.
//

import UIKit

class Repost: UIControl {

    private lazy var repostButton: UIButton = {
        var repostButton = UIButton()
        //likeButton.addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
        repostButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        return repostButton
    }()
    
    private lazy var repostCounterLabel: UILabel = {
        var repostCounterLabel = UILabel()
        repostCounterLabel.text = ""
        return repostCounterLabel
    }()
    
//    var active: Bool = false
    var counter: Int = 0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(repostButton)
        addSubview(repostCounterLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(repostButton)
        addSubview(repostCounterLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        repostButton.frame = CGRect(origin: .zero, size: CGSize(width: 20, height: 20))
        repostCounterLabel.frame = CGRect(origin: CGPoint(x: 30, y: 0), size: CGSize(width: 20, height: 20))
    }
    
    @objc func onTap(_ button: UIButton) {

//        if active == false {
//            active = true
//            button.setImage(UIImage(imageLiteralResourceName: "LikeImage"), for: .normal)
//            self.counter = counter + 1
//            commentCounterLabel.fadeTransition(1)
//            commentCounterLabel.text = String(counter)
//        } else if active == true {
//            active = false
//            button.setImage(UIImage(imageLiteralResourceName: "NotSelectedLikeImage"), for: .normal)
//            self.counter = counter - 1
//            commentCounterLabel.fadeTransition(1)
//            commentCounterLabel.text = String(counter)
//        }

        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       animations: {
                        self.repostButton.transform = .init(scaleX: 0.9, y: 0.9)
                       })
        UIView.animate(withDuration: 1,
                       delay: 0.2,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 30,
                       animations: {
                        self.repostButton.transform = .init(scaleX: 1, y: 1)
        })
        
    }
   
}

