//
//  Like.swift
//  SocialApp
//
//  Created by Иван Казанцев on 24.01.2021.
//

import UIKit

class Like: UIControl {
    
    private lazy var likeButton: UIButton = {
        var likeButton = UIButton()
        likeButton.addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
        likeButton.setImage(UIImage(imageLiteralResourceName: "NotSelectedLikeImage"), for: .normal)
        return likeButton
    }()
    
    private lazy var likeCounterLabel: UILabel = {
        var likeCounterLabel = UILabel()
        likeCounterLabel.text = ""
        return likeCounterLabel
    }()
    
    var active: Bool = false
    var counter: Int = 0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(likeButton)
        addSubview(likeCounterLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(likeButton)
        addSubview(likeCounterLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        likeButton.frame = CGRect(origin: .zero, size: CGSize(width: 20, height: 20))
        likeCounterLabel.frame = CGRect(origin: CGPoint(x: 30, y: 0), size: CGSize(width: 20, height: 20))
    }
    
    @objc func onTap(_ button: UIButton) {
        
        if active == false {
            active = true
            button.setImage(UIImage(imageLiteralResourceName: "LikeImage"), for: .normal)
            self.counter = counter + 1
            likeCounterLabel.fadeTransition(1)
            likeCounterLabel.text = String(counter)
        } else if active == true {
            active = false
            button.setImage(UIImage(imageLiteralResourceName: "NotSelectedLikeImage"), for: .normal)
            self.counter = counter - 1
            likeCounterLabel.fadeTransition(1)
            likeCounterLabel.text = String(counter)
        }

        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       animations: {
                        self.likeButton.transform = .init(scaleX: 0.9, y: 0.9)
                       })
        UIView.animate(withDuration: 1,
                       delay: 0.2,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 30,
                       animations: {
                        self.likeButton.transform = .init(scaleX: 1, y: 1)
        })
        
    }
   
}


