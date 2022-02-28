//
//  SelectBoxView.swift
//  MyGallery
//
//  Created by Nuno Silva on 28/02/2022.
//

import SwiftUI

struct SelectBoxView: View {
    
    @Binding var checked: Bool
    
    let text: String
    
    var body: some View {
        HStack{
            Image(systemName: checked ? "checkmark.square.fill" : "square")
                .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
                .onTapGesture {
                    self.checked.toggle()
                }
            
            Text(text)
                .foregroundColor(.primary)
                .font(.system(size: 12, weight: .semibold))
        }
    }
}

struct SelectBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SelectBoxView(checked: .constant(true), text: "Select row")
    }
}
