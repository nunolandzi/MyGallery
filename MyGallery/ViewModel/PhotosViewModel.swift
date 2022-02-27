//
//  PhotosViewModel.swift
//  MyGallery
//
//  Created by Nuno Silva on 25/02/2022.
//

import Foundation
import Combine

protocol PhotosViewModel {
    func getPhotos(params: String)
    func getFavPhotos(userID: String)
}

class PhotosViewModelImp: ObservableObject, PhotosViewModel {
    
    private var service: PhotosService
    
    private(set) var photos = [Photo]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState = .loading
    
    init(service: PhotosService) {
        self.service = service
    }
    
    func getPhotos(params: String) {
        self.state = .loading
        
        let cancellable = service.request(from: .getPhotos, params: params)
            .sink { res in
                switch res{
                case .finished:
                    self.state = .success(content: self.photos)
                case .failure(let error):
                    self.state = .failed(error: error)
                    break
                }
            } receiveValue: { response in
                self.photos = response.items
            }

        self.cancellables.insert(cancellable)
    }
    
    
    func getFavPhotos(userID: String) {
        self.state = .loading
        
        let cancellable = service.request(from: .getFavourites, params: userID)
            .sink { res in
                switch res{
                case .finished:
                    self.state = .success(content: self.photos)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { response in
                self.photos = response.items
            }
        
        self.cancellables.insert(cancellable)
    }
    
}
