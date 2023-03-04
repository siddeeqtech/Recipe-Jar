//
//  VideoURL.swift
//  Recipe Jar
//
//  Created by othman shahrouri on 2/20/23.
//

import Foundation
struct VideoURL:Codable {
    let youtubeLink: String
    let title: String
    let image: String
}

struct WebsiteURL:Codable {
    let websiteURL:String
}
