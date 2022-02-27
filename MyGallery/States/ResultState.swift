//
//  ResultState.swift
//  MyGallery
//
//  Created by Nuno Silva on 25/02/2022.
//

import Foundation

enum ResultState {
    case loading
    case success(content: [Photo])
    case failed(error: Error)
}
