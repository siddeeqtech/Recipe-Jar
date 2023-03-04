//
//  Ingredient.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 2/2/23.
//

import Foundation
struct Ingredient:TitleProtocol,Codable {
    init(name: String, order: Int, quantity: Double = 0.0, unit: String = "no unit") {
        self.name = name
        self.orderID = order
        self.quantity = quantity
        self.unit = unit
        //self.id = UUID()
    }
    
    //var id:UUID?
//    var orderID: Int
//    var name: String
//    let quantity: Double?
//    let unit: String?
    
    
    
    var name: String
    var quantity: Double?
    var unit: String?
    var orderID: Int
    
}
