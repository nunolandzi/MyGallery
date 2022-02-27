//
//  MyGalleryApp.swift
//  MyGallery
//
//  Created by Nuno Silva on 25/02/2022.
//

import SwiftUI

@main
struct MyGalleryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
            HomeView()
        }
    }
}
