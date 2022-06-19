//
//  MeetingEndingView.swift
//  MeetingNMusae
//
//  Created by Heeji Sohn on 2022/06/19.
//

import SwiftUI

struct MeetingEndingView: View {
    let screenWidth = UIScreen.main.bounds.width
    @State var animate = true
    var body: some View {
        
        VStack{
            VStack{
                Text("회의가")
                    .font(.title)
                        .fontWeight(.heavy)
                Text("종료되었습니다")
                    .font(.title)
                        .fontWeight(.heavy)
            }
            .padding(.top, -100)
            
            ZStack{
                
                
                Image("leftout")
                    .resizable()
                    .scaledToFit()
                    .offset(x:animate ? 0 : -screenWidth*0.6)
                    .animation(.easeIn(duration: 1.0), value: animate)
                
                Image("rightout")
                    .resizable()
                    .scaledToFit()
                    .offset(x:animate ? 0 : screenWidth*0.6)
                    .animation(.easeIn(duration: 1.0), value: animate)
                
                Button(action:{animate.toggle()}){
                    Image("desk")
                        .resizable()
                        .scaledToFit()
                }
            }
            .padding(.top,-50)
            
            
        }
    }
}

struct MeetingEndingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingEndingView()
    }
}
