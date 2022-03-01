//
//  SearchView.swift
//  MyGallery
//
//  Created by Nuno Silva on 28/02/2022.
//

import SwiftUI

struct SearchView: View {
    
    @State var feeds:[String] = []
    
    var body: some View {
        VStack{
            SearchBar(feeds: $feeds)
            ScrollView(.vertical){
                ForEach(feeds, id: \.self) { feed in
                    let params = feed.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
                    FeedView(title: feed, params: params)
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


struct SearchBar: View {
    @State var text: String = ""
 
    @State var isEditing: Bool = false
    
    @Binding var feeds:[String]
 
    var body: some View {
        HStack {
            
            TextField("Search", text: $text, onCommit: {
                isEditing = false
            })
                .padding(7)
                .padding(.horizontal, 35)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    if self.feeds.count > 2 {
                        let _ = self.feeds.removeFirst()
                        
                    }
                    self.feeds.append(self.text)
                    self.isEditing = false
                    self.text = ""
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Add")
                        .accentColor(.blue)
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
        .overlay(
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)
            }
            .padding(.horizontal,20)
        )
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(feeds: .constant([]))
    }
}
