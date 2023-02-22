//
//  Ingredient.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 2/2/23.
//

import Foundation
struct Ingredient: Identifiable,TitleProtocol {
    init(name: String, order: Int, quantity: Double = 0.0, unit: String = "no unit") {
        self.name = name
        self.order = order
        self.quantity = quantity
        self.unit = unit
    }
    
    var id = UUID()
    var order: Int
    var name: String
    let quantity: Double?
    let unit: String?
}
