//
//  PhotoDetailView.swift
//  MyGallery
//
//  Created by Nuno Silva on 26/02/2022.
//

import SwiftUI
import URLImage

struct PhotoDetailView: View {
    let photo: Photo
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            PhotoView(photo: photo, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width, cornerRadius: 0)
            
            Spacer()
        }
        .navigationTitle(photo.title ?? "No Title")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button {
                    
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.primary)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: FavesView(photo: photo)) {
                    Text("Fav")
                }
            }
        }
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(photo: Photo.dummyData)
    }
}
