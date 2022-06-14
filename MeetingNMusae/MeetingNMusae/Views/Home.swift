//
//  Home.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/13.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("회의하는 N무새")
                    .font(.custom("Apple SD Gothic Neo", size: 28))
                    .fontWeight(.heavy)
                    .padding(.bottom, 46)
                Image("회의하는N무새")
                    .frame(width: 360, height: 360)
                    .padding(.bottom, 84)
                VStack(alignment: .center, spacing: 16) {
                    NavigationLink(destination: RoomFindingView()) {
                        SelectBox(isDark: true, description: "방 만들기")
                    }
                    NavigationLink(destination: NicknameSettingView()) {
                        SelectBox(isDark: false, description: "입장하기")
                    }
                }// VStack
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }// NavigationView
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

