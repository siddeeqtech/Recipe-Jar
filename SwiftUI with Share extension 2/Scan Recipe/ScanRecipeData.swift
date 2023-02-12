//
//  ScanRecipe.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 11/3/22.
//

import Foundation


struct scanRecipeData:Identifiable {
    var id = UUID()
    var content:String
    
    init(content:String){
        self.content = content
        
    }
    
    
}
