//
//  HomeView.swift
//  MyGallery
//
//  Created by Nuno Silva on 25/02/2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = PhotosViewModelImp(service: PhotosServiceImp())
    
    @State var showFiltersMenu = false
    
    @State var feeds = [
        Feed(title: firstFeedTitle, params: firstRowParams, isChecked: true),
        Feed(title: secondFeedTitle, params: secondRowParams, isChecked: true),
        Feed(title: publicFeedTitle, params: publicFeedParams, isChecked: true)
    ]
    
    var body: some View {
        ZStack{
            Group{
                switch viewModel.state{
                case .loading:
                    ProgressView()
                case .failed(let error):
                    ErrorView(error: error) {
                        viewModel.getPhotos(params: feeds[0].title)
                    }
                case .success(let photos):
                    NavigationView{
                        ScrollView(.vertical){
                            VStack(alignment: .leading){
                                
                                if let checked = feeds.first?.isChecked {
                                    if checked {
                                        Text(feeds[0].title)
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
                            }
                            
                            ForEach(feeds, id: \.self) { feed in
                                if feed != feeds.first && feed.isChecked{
                                    FeedView(title: feed.title, params: feed.params)
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
                            
                            ToolbarItem(placement: .navigationBarTrailing) {
                                
                                NavigationLink(destination: SearchView()) {
                                    Image(systemName: "magnifyingglass.circle")
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
                    ForEach(Array(feeds.enumerated()), id: \.offset) { index,feed in
                        SelectBoxView(feed: $feeds[index])
                    }
                }
                .listStyle(.grouped)
                .frame(height: UIScreen.main.bounds.height*1/3)
                .offset(y: showFiltersMenu ? 0 : UIScreen.main.bounds.height*1/3 + 20)
            }
            .background{
                Color
                    .black
                    .opacity(showFiltersMenu ? 0.3 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        let filter = feeds.filter{$0.isChecked}
                        withAnimation(.spring()) {
                            if !filter.isEmpty {
                                showFiltersMenu = false
                            }
                        }
                    }
            }
            
            
        }
        .onAppear {
            viewModel.getPhotos(params: feeds[0].title)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct Feed: Hashable {
    
    let title: String
    let params: String
    var isChecked: Bool
}

extension Feed{
    static var dummyData = Feed.init(title: "Title", params: "Title", isChecked: true)
}
