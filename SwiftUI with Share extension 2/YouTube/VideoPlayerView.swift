//
//  VideoPlayerView.swift
//  Recipe Jar
//
//  Created by othman shahrouri on 2/12/23.
//

import AVKit
import SwiftUI

struct VideoPlayerView: View {
    
    init(videoURL: URL) {
        _videoURL = State(initialValue: videoURL)
        
        player = AVPlayer(url: videoURL)
        player.play()
        
    }
    
    @State var videoURL:URL
    private var player:AVPlayer!
    var body: some View {
        VStack {
            VideoPlayer(player: AVPlayer(playerItem: AVPlayerItem(url: videoURL)))
              //  .aspectRatio(3/2, contentMode: .fit)

            
            
        }
        //
        .onAppear{
            // player = AVPlayer(playerItem: AVPlayerItem(url: videoURL))
           // player.currentItem.
        }
    }
    
}

//struct VideoPlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//       // VideoPlayerView(player: AVPlayer(),videoURL: <#T##URL#>)
//    }
//}




