//
//  YouTubePlayerView.swift
//  Recipe Jar
//
//  Created by othman shahrouri on 2/12/23.
//

import SwiftUI

import SwiftUI
import YouTubePlayerKit

struct YouTubeView: View {

    @State var youTubePlayer: YouTubePlayer!

    var body: some View {
        //ZStack{
         
        VStack(spacing:-10){
                YouTubePlayerView(self.youTubePlayer) { state in
                    // Overlay ViewBuilder closure to place an overlay View
                    // for the current `YouTubePlayer.State`
                    switch state {
                    case .idle:
                        ProgressView()
                    case .ready:
                        EmptyView()
                    case .error(let error):
                        Text(verbatim: "YouTube player couldn't be loaded")
                     
                    }
                }
                .aspectRatio(1.5, contentMode: .fit)

                
             
                Spacer()
            StepView(step: Step(name: "hahahahahahahaha", order: -1))
            
        }
//        .background(.blue)
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .ignoresSafeArea(edges:.top)
        .navigationBarBackButtonHidden(true)
       // .navigationBarHidden(true)
        .navigationTitle("Good Old-Fashioned Pancakes")
        .navigationBarTitleDisplayMode(.inline)
            //.edgesIgnoringSafeArea(.all)

            
            
            
        //}
      
        
     
    }

}

struct YouTubePlayerView_Previews: PreviewProvider {
    static var previews: some View {
        YouTubeView()
    }
}
