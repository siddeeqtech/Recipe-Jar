//
//  Step.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 2/2/23.
//

import Foundation

struct Step: Identifiable,TitleProtocol {
    init(name: String, order: Int, quantity: Double = 0.0, unit: String = "no unit") {
        self.name = name
        self.order = order
    }
    
   
    var order:Int
    var id = UUID()
    var name: String
   
}
struct Welcome1:Decodable {
    let name: String
    
    
    
//    enum CodingKeys: String, CodingKey {
//            case iReceivedYourName = "I received your name : "
//    }
}
