//
//  Comment.swift
//  SocialApp
//
//  Created by Иван Казанцев on 02.03.2021.
//

import UIKit

class Comment: UIControl {

    private lazy var commentButton: UIButton = {
        var commentButton = UIButton()
        //likeButton.addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
        commentButton.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        return commentButton
    }()
    
    private lazy var commentCounterLabel: UILabel = {
        var commentCounterLabel = UILabel()
        commentCounterLabel.text = ""
        return commentCounterLabel
    }()
    
//    var active: Bool = false
    var counter: Int = 0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(commentButton)
        addSubview(commentCounterLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(commentButton)
        addSubview(commentCounterLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        commentButton.frame = CGRect(origin: .zero, size: CGSize(width: 20, height: 20))
        commentCounterLabel.frame = CGRect(origin: CGPoint(x: 30, y: 0), size: CGSize(width: 20, height: 20))
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
                        self.commentButton.transform = .init(scaleX: 0.9, y: 0.9)
                       })
        UIView.animate(withDuration: 1,
                       delay: 0.2,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 30,
                       animations: {
                        self.commentButton.transform = .init(scaleX: 1, y: 1)
        })
        
    }
   
}


    
