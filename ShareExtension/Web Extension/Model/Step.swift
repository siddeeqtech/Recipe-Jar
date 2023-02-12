//
//  Step.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 2/2/23.
//

import Foundation

struct Step: Identifiable,TitleProtocol {
   
    var order:Int
    var id = UUID()
    var title: String
    init(title: String,order:Int) {
        self.title = title
        self.order = order
    }
}
