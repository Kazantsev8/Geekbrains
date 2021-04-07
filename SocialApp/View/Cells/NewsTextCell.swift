//
//  NewsTextCell.swift
//  SocialApp
//
//  Created by Иван Казанцев on 06.04.2021.
//

import UIKit

protocol TextCellDelegate: class {
    func textCellTapped(at indexPath: IndexPath)
}

class NewsTextCell: UITableViewCell {
    @IBOutlet var newsText: UITextView!
    public weak var delegate: TextCellDelegate?
    public var indexPath = IndexPath()
    
    public func configureNewsTextCell (with news: News?) {
        guard let text = news?.newsText else {return}
        newsText.text = text
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGR.numberOfTapsRequired = 2
        newsText.addGestureRecognizer(tapGR)
        newsText.isUserInteractionEnabled = true
    }
    
    @objc func tapped() {
        delegate?.textCellTapped(at: indexPath)
    }
}
