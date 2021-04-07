//
//  Ext Date.swift
//  SocialApp
//
//  Created by Иван Казанцев on 06.04.2021.
//

import Foundation

extension Date {
    func toString( dateFormat format  : String ) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
