//
//  PhotoView.swift
//  MyGallery
//
//  Created by Nuno Silva on 25/02/2022.
//

import SwiftUI
import URLImage

struct PhotoView: View {
    
    let photo: Photo
    
    
    var body: some View {
        VStack{
            if let photoPath = photo.media.m, let photoURL = URL(string: photoPath){
                URLImage(photoURL) {
                    EmptyView()
                } inProgress: { progress in
                    ProgressView()
                } failure: { error, retry in
                    PlaceholderImageView()
                } content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                .cornerRadius(0)
            }else{
                PlaceholderImageView()
            }
            
        }
        .padding()
    }
}

struct PlaceholderImageView: View {
    var body: some View{
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(Color.white)
            .frame(width: 100, height: 100)
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(photo: Photo.dummyData)
            .previewLayout(.sizeThatFits)
    }
}
