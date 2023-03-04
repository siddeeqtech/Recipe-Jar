//
//  Step.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 2/2/23.
//

import Foundation

struct Step:TitleProtocol2,Codable {
    init(name: String, order: Int) {
        self.name = name
        self.orderID = order
       // self.id = UUID()
    }
    
   
    var orderID:Int
    //var id: UUID?
    var name: String
   
}






struct Welcome1:Decodable {
    let name: String
    
    
    
//    enum CodingKeys: String, CodingKey {
//            case iReceivedYourName = "I received your name : "
//    }
}
