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
                            
                            ThumbnailView(photo: item, width: 90, height: 90, cornerRadius: 0)
                        } //: LOOP
                    } //: GRID
                }.navigationTitle("User Faves")
                    .overlay{
                        VStack{
                            Image(systemName: "doc.text.magnifyingglass")
                                .foregroundColor(.gray)
                                .font(.system(size: 50, weight: .heavy))
                            
                            Text("Nothing to show here!")
                                .foregroundColor(.black)
                                .font(.system(size: 30, weight: .heavy))
                                .multilineTextAlignment(.center)
                        }
                        .opacity(photos.isEmpty ? 1 : 0)
                    }
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
