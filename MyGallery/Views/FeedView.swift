//
//  FeedView.swift
//  MyGallery
//
//  Created by Nuno Silva on 28/02/2022.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var viewModel = PhotosViewModelImp(service: PhotosServiceImp())
    
    let title: String
    let params: String
    let thumbnailSize:CGFloat = 90
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text(title)
                .foregroundColor(.primary)
                .font(.system(size: 30, weight: .bold))
                .padding(.horizontal)
            
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.photos) { item in
                        NavigationLink(destination: PhotoDetailView(photo: item)) {
                            ThumbnailView(photo: item, width: thumbnailSize, height: thumbnailSize, cornerRadius: 10)
                            
                        }
                        
                    }
                }
            }
        }
        .onAppear {
            viewModel.getPhotos(params: params)
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(title: "", params: "")
    }
}
