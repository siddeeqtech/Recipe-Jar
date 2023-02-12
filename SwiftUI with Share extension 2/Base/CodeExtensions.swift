//
//  CodeExtensions.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 2/2/23.
//

import Foundation
import SwiftUI
import UIKit
class CodeExtensions {
    static let sharedDefault = UserDefaults(suiteName: "group.recipesFolders")!
    
    private init(){
        
    }
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}


