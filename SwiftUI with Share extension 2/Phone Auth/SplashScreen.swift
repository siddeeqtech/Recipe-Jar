//
//  SplashScreen.swift
//  Recipe Jar
//
//  Created by othman shahrouri on 3/8/23.
//

import SwiftUI

struct SplashScreen: View {
    @AppStorage("log_status") var log_status = false
    
    var body: some View {
        
        NavigationView{
            
            if log_status {
                HomeView()
            }
            else {
                OnBoardScreen()
            }
            
        }
        
        
        
//        ZStack{
//            Color.clear
//        }.background(
//        Image("LaunchScreen")
//        ).ignoresSafeArea(.all)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
