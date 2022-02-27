//
//  APIError.swift
//  MyGallery
//
//  Created by Nuno Silva on 25/02/2022.
//

import Foundation

enum APIError: Error{
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError: LocalizedError{
    var errorDescription: String?{
        switch self{
        case .decodingError:
            return "Failed to decode the object from service"
        case .errorCode(let code):
            return "\(code) - Something went wrong"
        case .unknown:
            return "The error is unknown"
        }
    }
}
