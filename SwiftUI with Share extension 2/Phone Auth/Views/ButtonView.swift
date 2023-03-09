//
//  ButtonView.swift
//  Recipe Jar
//
//  Created by othman shahrouri on 3/6/23.
//

import SwiftUI

struct ButtonView: View {
    @State var buttonTitle:String = ""
    var function: () async ->  Void
    var body: some View {
        Button(buttonTitle) {
            print("Button pressed!")
            
            Task{
                self.function
            }
            //self.function()
        }
        
        .padding(.vertical,20)
        .padding(.horizontal,80)
        .background(CustomColor.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
        .foregroundColor(.white)
        .font(Font.custom("FiraSans-Medium", size: 20))
        
        
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        
        ButtonView(buttonTitle:"Get started", function:{})
    }
}
