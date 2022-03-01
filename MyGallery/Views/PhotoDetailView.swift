//
//  PhotoDetailView.swift
//  MyGallery
//
//  Created by Nuno Silva on 26/02/2022.
//

import SwiftUI
import URLImage

struct PhotoDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var share: Bool = false
    @State var url = URL(string: "")
    
    let photo: Photo
    
    var body: some View {
        VStack(spacing: 10){
            PhotoView(photo: photo)
            
            
            Text("by: \(photo.author ?? "")")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("Published: \(photo.published ?? "")")
                .font(.caption)
                .foregroundColor(.gray)
            
            NavigationLink(destination: FavesView(photo: photo)) {
                Text("User Favourites")
            }

            
            
            Spacer()
        }
        .navigationTitle(photo.title ?? "No Title")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button {
                    self.share = true
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.primary)
                }
            }
        }
        .sheet(isPresented: $share, content:{
            
            let title = photo.title ?? "KI"
            
            if let url = URL(string: photo.media.m){
                ShareSheet(items: [url, title])
            }
            
            
        })
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(photo: Photo.dummyData)
    }
}
