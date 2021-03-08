//
//  UserPhotoCollectionViewController.swift
//  SocialApp
//
//  Created by Иван Казанцев on 17.01.2021.
//

import UIKit


class UserProfileCollectionViewController: UICollectionViewController {
    
    var currentImage: Int = 0
    var friendPhotos = [UIImage]()
    var interactivePhotoAnimator: UIViewPropertyAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserProfileCell", for: indexPath) as! UserProfileCell
        
        cell.userProfileAvatarImage.image = friendPhotos[currentImage]
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:cell:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.collectionView.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:cell:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.collectionView.addGestureRecognizer(swipeLeft)
        
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: 125, y:125), radius: 125, startAngle: 0, endAngle: 360, clockwise: true)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        

        cell.userProfileAvatarImage.layer.mask = maskLayer
        cell.userProfileAvatarImageShadow.addShadow()
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer, cell: UserProfileCell) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right:
                if currentImage == 0 {
                    currentImage = friendPhotos.count - 1
                } else {
                    currentImage -= 1
                }
            case .left:
                if currentImage == friendPhotos.count - 1 {
                    currentImage = 0
                } else {
                    currentImage += 1
                }
            default:
                break
            }
        }
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    
}

class UserProfileAvatarImageShadow: UIView {
    
    @IBInspectable var shadowColor: UIColor = .black
    @IBInspectable var shadowRadius: CGFloat = 6
    @IBInspectable var shadowOpacity: Float = 0.9
    
    func addShadow() {
        layer.masksToBounds = false
        layer.cornerRadius = 125
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize.zero
    }
}

