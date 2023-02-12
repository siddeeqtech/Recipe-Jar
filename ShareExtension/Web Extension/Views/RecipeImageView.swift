//
//  RecipeImageView.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 2/2/23.
//

import Foundation
import SwiftUI
struct RecipeImageView: View {
    @State var imageName:String!
    var body: some View {
        
        Image(imageName)
            .resizable()
            .aspectRatio(1.6,contentMode:.fit)
            .scaledToFill()
            .clipShape(RoundedRectangle(cornerRadius: 10))
        
            .frame(width: UIScreen.screenWidth*0.9, height: UIScreen.screenHeight*0.2, alignment: .top)
    }
    
    
}
