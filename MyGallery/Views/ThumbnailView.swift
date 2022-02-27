//
//  ThumbnailView.swift
//  MyGallery
//
//  Created by Nuno Silva on 27/02/2022.
//

import SwiftUI
import URLImage

struct ThumbnailView: View {
    let photo: Photo
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    
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
                .frame(width: width, height: height)
                .cornerRadius(cornerRadius)
            }else{
                PlaceholderImageView()
            }
            
            Text(photo.title ?? "")
                .foregroundColor(.primary)
                .font(.system(size: 12, weight: .semibold))
                .lineLimit(1)
            
        }
        .padding()
        .frame(width: 100)
    }
}

struct ThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailView(photo: Photo.dummyData, width: 80, height: 80, cornerRadius: 8)
    }
}
