//
//  Recipe.swift
//  Recipe Jar
//
//  Created by othman shahrouri on 2/20/23.
//

import Foundation
struct Recipe {
    let name: String
    let time: Int
    let pictureURL: String
    let videoURL: VideoURL
    let isEditorChoice: Bool
    let ingredients: [Ingredient]
    let steps: [Step]
}
