//
//  FavesView.swift
//  MyGallery
//
//  Created by Nuno Silva on 26/02/2022.
//

import SwiftUI

struct FavesView: View {
    @StateObject var viewModel = PhotosViewModelImp(service: PhotosServiceImp())
    
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn: Double = 3.0
    
    let photo: Photo
    
    
    var body: some View {
        Group{
            switch viewModel.state{
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error) {
                    viewModel.getFavPhotos(userID: photo.author_id ?? "")
                }
            case .success(let photos):
                ScrollView(.vertical){
                    LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                        ForEach(photos) { item in
                            ThumbnailView(photo: photo, width: 90, height: 90, cornerRadius: 0)
                        } //: LOOP
                    } //: GRID
                }.navigationTitle("Favourites")
            }
        }
        .onAppear {
            gridLayout = Array(repeating: .init(.flexible()), count: Int(gridColumn))
            viewModel.getFavPhotos(userID: photo.author_id ?? "")
        }
    }
}

struct FavesView_Previews: PreviewProvider {
    static var previews: some View {
        FavesView(photo: Photo.dummyData)
    }
}
