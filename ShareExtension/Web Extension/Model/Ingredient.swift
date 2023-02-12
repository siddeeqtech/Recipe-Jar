//
//  Ingredient.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 2/2/23.
//

import Foundation
struct Ingredient: Identifiable,TitleProtocol {
    init(title: String,order:Int) {
        self.title = title
        self.order = order
    }
    
    var id = UUID()
    var order: Int
    var title: String
}
