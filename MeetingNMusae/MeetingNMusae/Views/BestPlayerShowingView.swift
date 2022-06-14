//
//  BestPlayerShowingView.swift
//  MeetingNMusae
//
//  Created by Heeji Sohn on 2022/06/14.
//

import SwiftUI

struct BestPlayerShowingView: View {
    var body: some View {
        
        ZStack {
            LottieView(name: "confetti", loopMode: .loop)
                        .scaledToFill()
                    .ignoresSafeArea(edges:.top)
        }
    }
}

struct BestPlayerShowingView_Previews: PreviewProvider {
    static var previews: some View {
        BestPlayerShowingView()
    }
}
