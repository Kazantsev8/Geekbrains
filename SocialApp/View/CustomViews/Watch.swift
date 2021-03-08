//
//  Watch.swift
//  SocialApp
//
//  Created by Иван Казанцев on 02.03.2021.
//

import UIKit

class Watch: UIControl {

    private lazy var watchButton: UIButton = {
        var watchButton = UIButton()
        //likeButton.addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
        watchButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        return watchButton
    }()
    
    private lazy var watchCounterLabel: UILabel = {
        var watchCounterLabel = UILabel()
        watchCounterLabel.text = ""
        return watchCounterLabel
    }()
    
//    var active: Bool = false
    var counter: Int = 0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(watchButton)
        addSubview(watchCounterLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(watchButton)
        addSubview(watchCounterLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        watchButton.frame = CGRect(origin: .zero, size: CGSize(width: 20, height: 20))
        watchCounterLabel.frame = CGRect(origin: CGPoint(x: 30, y: 0), size: CGSize(width: 20, height: 20))
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
                        self.watchButton.transform = .init(scaleX: 0.9, y: 0.9)
                       })
        UIView.animate(withDuration: 1,
                       delay: 0.2,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 30,
                       animations: {
                        self.watchButton.transform = .init(scaleX: 1, y: 1)
        })
        
    }
   
}
