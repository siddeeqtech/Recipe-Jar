//
//  BlurView.swift
//  Recipe Jar
//
//  Created by othman shahrouri on 3/3/23.
//

import SwiftUI
var BlurView: some View {
    
        ZStack {
            Rectangle()
                .foregroundColor(Color.white.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
                
            
            
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottom)
           
//
            
        }
      //  .background(.white)
        .ignoresSafeArea()
  
}

