//
//  ShareSheet.swift
//  MyGallery
//
//  Created by Nuno Silva on 28/02/2022.
//

import Foundation
import SwiftUI

struct ShareSheet : UIViewControllerRepresentable{
    var items: [Any]
    func makeUIViewController(context: Context) -> some UIViewController {
        
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}
