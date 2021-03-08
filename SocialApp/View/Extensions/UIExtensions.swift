//
//  UIExtensions.swift
//  SocialApp
//
//  Created by Иван Казанцев on 02.03.2021.
//

import UIKit

extension UIView {
    
    func fadeTransition(_ duration:CFTimeInterval) {
            let animation = CATransition()
            animation.timingFunction = CAMediaTimingFunction(name:
                CAMediaTimingFunctionName.easeInEaseOut)
            animation.type = CATransitionType.fade
            animation.duration = duration
            layer.add(animation, forKey: CATransitionType.fade.rawValue)
        }
    
}
