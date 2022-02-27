//
//  HomeView.swift
//  MyGallery
//
//  Created by Nuno Silva on 25/02/2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = PhotosViewModelImp(service: PhotosServiceImp())
    @StateObject var secondRowViewModel = PhotosViewModelImp(service: PhotosServiceImp())
    @StateObject var publicFeedViewModel = PhotosViewModelImp(service: PhotosServiceImp())
    
    var body: some View {
        Group{
            switch viewModel.state{
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error) {
                    viewModel.getPhotos(params: firstRowParams)
                }
            case .success(let photos):
                NavigationView{
                    ScrollView(.vertical){
                        VStack(alignment: .leading){
                            Text(firstRowParams)
                                .foregroundColor(.primary)
                                .font(.system(size: 30, weight: .bold))
                                .padding(.vertical)
                            
                            ScrollView (.horizontal, showsIndicators: false) {
                                 HStack {
                                     ForEach(photos) { item in
                                         NavigationLink(destination: PhotoDetailView(photo: item)) {
                                             PhotoView(photo: item, width: 80, height: 80, cornerRadius: 10)
                                             
                                         }
                                             
                                     }
                                 }
                            }
                        }
                        
                        
                        if !secondRowViewModel.photos.isEmpty {
                            
                            VStack(alignment: .leading){
                                Text(secondRowParams)
                                    .foregroundColor(.primary)
                                    .font(.system(size: 30, weight: .bold))
                                    .padding(.vertical)
                             
                                ScrollView (.horizontal, showsIndicators: false) {
                                     LazyHStack {
                                         ForEach(secondRowViewModel.photos) { item in
                                             PhotoView(photo: item, width: 80, height: 80, cornerRadius: 10)

                                         }
                                     }
                                }
                            }
                            
                        }

                        if !publicFeedViewModel.photos.isEmpty {
                            VStack(alignment: .leading){
                                Text(publicFeedParams)
                                    .foregroundColor(.primary)
                                    .font(.system(size: 30, weight: .bold))
                                    .padding(.vertical)
                                
                                ScrollView (.horizontal, showsIndicators: false) {
                                     LazyHStack {
                                         ForEach(secondRowViewModel.photos) { item in
                                             PhotoView(photo: item, width: 80, height: 80, cornerRadius: 10)

                                         }
                                     }
                                }
                            }
                            
                        }
                    }
                    .navigationTitle(Text(APPTitle))
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            
        }.onAppear {
            viewModel.getPhotos(params: firstRowParams)
            secondRowViewModel.getPhotos(params: secondRowParams)
            publicFeedViewModel.getPhotos(params: "")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
