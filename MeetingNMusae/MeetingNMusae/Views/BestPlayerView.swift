//
//  BestPlayerView.swift
//  MeetingNMusae
//
//  Created by Heeji Sohn on 2022/06/13.
//

import SwiftUI

struct BestPlayerView: View {
    var body: some View {
        LottieView(name: "confetti", loopMode: .loop)
            .scaledToFill()
            .ignoresSafeArea(edges:.top)
  //          .frame(width: 500, height: 1000)
                    
    }
}
    
    struct BestPlayerView_Previews: PreviewProvider {
        static var previews: some View {
            BestPlayerView()
        }
    }
