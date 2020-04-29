//
//  AnimeError.swift
//  AnimeBrowser
//
//  Created by Leonardo Diaz on 4/29/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import Foundation
enum AnimeError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach server."
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "The server responded with bad data."
        }
    }
}
