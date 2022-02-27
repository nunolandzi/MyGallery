//
//  PhotoModel.swift
//  MyGallery
//
//  Created by Nuno Silva on 25/02/2022.
//

import Foundation

struct PhotosModel: Codable{
    let items: [Photo]
}


struct Photo: Codable, Identifiable{
    let id = UUID()
    let title: String?
    let link: String?
    let media: Media
    let date_taken: Date?
    let photoDescription: String?
    let published: String?
    let author: String?
    let author_id: String?
    let tags: String?
    
    enum CodingKeys: String, CodingKey {
        case title, link, media,date_taken
        case photoDescription = "description"
        case published, author, author_id, tags
    }
}

struct Media: Codable{
    let m: String
}


extension Photo{
    static var dummyData = Photo.init(title: "Photo 1 photo2 photo 3 photo 4",
                                      link: "https://www.flickr.com/photos/tags/kittensdogs/",
                                      media: Media.init(m: "https://live.staticflickr.com/3602/3469108556_9fb89cd8a4_m.jpg"),
                                      date_taken: Date(),
                                      photoDescription:  " <p><a href=\"https://www.flickr.com/people/23713425@N02/\">fireofpele</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/23713425@N02/3469108556/\" title=\"Lady and Dover in Delaware.\"><img src=\"https://live.staticflickr.com/3602/3469108556_9fb89cd8a4_m.jpg\" width=\"160\" height=\"240\" alt=\"Lady and Dover in Delaware.\" /></a></p> ", published: "2009-04-23T18:33:48Z",
                                      author: "nobody@flickr.com (\"fireofpele\")",
                                      author_id: "57440551@N03",
                                      tags: "kittensdogs gspdoverdelware")
}

