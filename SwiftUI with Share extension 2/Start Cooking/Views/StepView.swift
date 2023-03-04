//
//  StepView.swift
//  Steps Screen Recipe Jar
//
//  Created by othman shahrouri on 2/5/23.
//

import SwiftUI

struct StepView: View {
    @State var step:Step
    var body: some View {
        
        
        VStack(alignment: .leading) {
            Text("Step \(step.orderID)")
                .font(Font.custom("FiraSans-Bold", size: 24))
                .padding(.bottom, 10)//0.03053435 of screen width
            
           
                ScrollView {
                    VStack {
                        // Place a single empty / "" at the top of your stack.
                        // It will consume no vertical space.
                        Text("")
                            .fixedSize(horizontal: false, vertical: true)
                        Text(step.name)
                              .fixedSize(horizontal: false, vertical: true)
                    }
                }
           
          
            
            //Text(step.content)
                .font(Font.custom("FiraSans-Medium", size: 18))
                .lineSpacing(5)
                //.lineLimit(13)
                .foregroundColor(Color(uiColor: UIColor(red: 35.0/255.0, green: 41.0/255.0, blue: 70.0/255.0, alpha: 1)))

           
        }

        .frame(maxWidth: .infinity,maxHeight: 400, alignment: .topLeading)//600 = 0.70422535 of screen height

        .padding(.horizontal, 45)//0.11450382 of screen width
    }
}

struct StepView_Previews: PreviewProvider {
    static var previews: some View {
        StepView(step: Step(name: "step 404", order: 1))
    }
}
