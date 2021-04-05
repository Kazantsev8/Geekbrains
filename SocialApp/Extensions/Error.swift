//
//  Error.swift
//  SocialApp
//
//  Created by Иван Казанцев on 28.03.2021.
//

import Foundation

enum NetworkError: Error {
    case error(message: String)
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error(let message):
            return NSLocalizedString(message, comment: "")
        }
    }
}
