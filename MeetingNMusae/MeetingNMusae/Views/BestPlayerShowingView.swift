//
//  BestPlayerShowingView.swift
//  MeetingNMusae
//
//  Created by Heeji Sohn on 2022/06/14.
//

import SwiftUI

struct BestPlayerShowingView: View {
    
    let imageName = "금고무새"
    var body: some View {
        
        ZStack {

            VStack {
                Text("최고의 플레이어!")
                    .font(.system(size:24))
                    .fontWeight(.bold)
                    .padding(.bottom, 92)
                    .padding(.top, 30)
                
                VStack {
    
                    Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width:155,height:155)
                }
                .background(CharacterBox())
                Spacer()
            }
            
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
