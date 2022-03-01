//
//  PhotosService.swift
//  MyGallery
//
//  Created by Nuno Silva on 25/02/2022.
//

import Foundation
import Combine

//Interact with API

//Make class testabel
protocol PhotosService{
    func request(from endpoint: PhotosAPI, params: String) -> AnyPublisher<PhotosModel, APIError> //Subscribe and listen to an event
}


struct PhotosServiceImp: PhotosService {
    func request(from endpoint: PhotosAPI, params: String) -> AnyPublisher<PhotosModel, APIError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.request(with: params))
            
            .receive(on: DispatchQueue.main)
            .mapError{_ in APIError.unknown}
            .flatMap{data, response -> AnyPublisher<PhotosModel, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    
                    return Just(data)
                        .decode(type: PhotosModel.self, decoder: jsonDecoder)
                        .mapError{error in
                            return APIError.decodingError}
                        .eraseToAnyPublisher()
                }else{
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
                
            }
            .eraseToAnyPublisher()
    }
    
    
}

