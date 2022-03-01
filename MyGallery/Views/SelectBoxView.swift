//
//  SelectBoxView.swift
//  MyGallery
//
//  Created by Nuno Silva on 28/02/2022.
//

import SwiftUI

struct SelectBoxView: View {
    
    @Binding var feed: Feed
    
    var body: some View {
        HStack{
            Image(systemName: feed.isChecked ? "checkmark.square.fill" : "square")
                .foregroundColor(feed.isChecked ? Color(UIColor.systemBlue) : Color.secondary)
                .onTapGesture {
                    self.feed.isChecked.toggle()
                }
            
            Text(feed.title)
                .foregroundColor(.primary)
                .font(.system(size: 12, weight: .semibold))
        }
    }
}


struct SelectBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SelectBoxView(feed: .constant(Feed.dummyData))
    }
}
