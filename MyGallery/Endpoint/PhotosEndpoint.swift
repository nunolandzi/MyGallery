//
//  PhotosEndpoint.swift
//  MyGallery
//
//  Created by Nuno Silva on 25/02/2022.
//

import Foundation


protocol APIBuilder {
    var baseUrl: String { get }
    var path: String { get }
    var format: String { get }
    func request(with params: String) -> URL
}


enum PhotosAPI{
    case getPhotos
    case getFavourites
}

extension PhotosAPI: APIBuilder{
    func request(with params: String) -> URL {
        switch self {
        case .getPhotos:
            let allParams = "&tags=\(params)"
            
            guard let url = URL(string: "\(self.baseUrl)\(path)\(format)\(allParams)") else{
                return URL(string: "")!
            }
            
            return url
            
        case .getFavourites:
            let id = "&id=\(params)"
            
            guard let url = URL(string: "\(self.baseUrl)\(self.path)\(id)\(format)")else{
                return URL(string: "")!
            }
            print(url)
            return url
        }
    }
    
    var baseUrl: String {
        return "https://www.flickr.com/services/feeds/"
    }
    
    var path: String {
        switch self {
        case .getPhotos:
            return "photos_public.gne?"
        case .getFavourites:
            return "photos_faves.gne?"
        }
    }
    
    
    var format: String {
        return "&format=json&nojsoncallback=1"
    }
    
}
