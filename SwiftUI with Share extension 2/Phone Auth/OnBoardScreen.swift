//
//  PhoneAuthScreen.swift
//  Recipe Jar
//
//  Created by othman shahrouri on 3/5/23.
//

import SwiftUI

struct OnBoardScreen: View {
    @State var isPhoneViewPresented = false // stay onboard or move to auth screen

    var body: some View {
        ZStack{

            VStack(spacing: 120){
                
                VStack{
                    Image("SplashScreenPerson")
    //Spacer()
                    Text("Enjoy your recipes with Whisk")
                        .font(Font.custom("FiraSans-Medium", size: 20))

                        .foregroundColor(CustomColor.navy)
                        .padding(.top,50)
                }
                
                Button("Get started") {
                    print("Button pressed!")
                    isPhoneViewPresented = true
                    
                }
                
                .padding(.vertical,20)
                .padding(.horizontal,80)
                .background(CustomColor.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                .foregroundColor(.white)
                .font(Font.custom("FiraSans-Medium", size: 20))
            }
            
            NavigationLink(destination: PhoneAuthScreen(), isActive: $isPhoneViewPresented) { EmptyView() }

            
            
//            NavigationLink{
//                PhoneAuthScreen(phoneNumber: "")
//            }label: {
//                Text("Phone Auth")
//            }
        }.background(Image("SplashScreenBG"))
    }
    
    
    
    
}

struct OnBoardScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardScreen()
    }
}
