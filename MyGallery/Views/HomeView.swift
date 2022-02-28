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
    
    let filters = [firstRowParams, secondRowParams, publicFeedParams]
    
    @State var hideFirstFeed = false
    @State var hideSecondFeed = false
    @State var hidePublicFeed = false
    @State var showFiltersMenu = false
    
    var body: some View {
        ZStack{
            Group{
                switch viewModel.state{
                case .loading:
                    ProgressView()
                case .failed(let error):
                    ErrorView(error: error) {
                        viewModel.getPhotos(params: firstRowParams)
                        secondRowViewModel.getPhotos(params: secondRowParams)
                        publicFeedViewModel.getPhotos(params: "")
                    }
                case .success(let photos):
                    NavigationView{
                        ScrollView(.vertical){
                            VStack(alignment: .leading){
                                
                                if !hideFirstFeed {
                                    Text(firstRowParams)
                                        .foregroundColor(.primary)
                                        .font(.system(size: 30, weight: .bold))
                                        .padding(.horizontal)
                                    
                                    ScrollView (.horizontal, showsIndicators: false) {
                                         HStack {
                                             ForEach(photos) { item in
                                                 NavigationLink(destination: PhotoDetailView(photo: item)) {
                                                     ThumbnailView(photo: item, width: 80, height: 80, cornerRadius: 10)
                                                     
                                                 }
                                                     
                                             }
                                         }
                                    }
                                }
                            }
                            
                            
                            if !secondRowViewModel.photos.isEmpty && !hideSecondFeed{
                                
                                VStack(alignment: .leading){
                                    Text(secondRowParams)
                                        .foregroundColor(.primary)
                                        .font(.system(size: 30, weight: .bold))
                                        .padding(.horizontal)
                                 
                                    ScrollView (.horizontal, showsIndicators: false) {
                                         HStack {
                                             ForEach(secondRowViewModel.photos) { item in
                                                 NavigationLink(destination: PhotoDetailView(photo: item)) {
                                                     ThumbnailView(photo: item, width: 80, height: 80, cornerRadius: 10)
                                                     
                                                 }

                                             }
                                         }
                                    }
                                }
                                
                            }

                            if !publicFeedViewModel.photos.isEmpty && !hidePublicFeed {
                                VStack(alignment: .leading){
                                    Text(publicFeedParams)
                                        .foregroundColor(.primary)
                                        .font(.system(size: 30, weight: .bold))
                                        .padding(.horizontal)
                                    
                                    ScrollView (.horizontal, showsIndicators: false) {
                                         HStack {
                                             ForEach(publicFeedViewModel.photos) { item in
                                                 NavigationLink(destination: PhotoDetailView(photo: item)) {
                                                     ThumbnailView(photo: item, width: 80, height: 80, cornerRadius: 10)
                                                     
                                                 }

                                             }
                                         }
                                    }
                                }
                                
                            }
                        }
                        .navigationTitle(Text(APPTitle))
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    withAnimation(.spring()) {
                                        showFiltersMenu = true
                                    }
                                } label: {
                                    Image(systemName: "pencil.circle")
                                        .foregroundColor(.primary)
                                }

                            }
                        }
                    }
                }
                
            }
            
            VStack{
                Spacer()
                
                    List{
                        ForEach(filters, id: \.self) { filter in
                            if filter == firstRowParams {
                                SelectBoxView(checked: $hideFirstFeed, text: filter)
                            }else if filter == secondRowParams{
                                SelectBoxView(checked: $hideSecondFeed, text: filter)
                            }else{
                                SelectBoxView(checked: $hidePublicFeed, text: filter)
                            }
                            
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height*1/3)
                    .offset(y: showFiltersMenu ? 0 : UIScreen.main.bounds.height*1/3 + 20)
            }
            .background{
                Color
                    .black
                    .opacity(showFiltersMenu ? 0.3 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showFiltersMenu = false
                        }
                    }
            }
            
            
        }
        .onAppear {
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
