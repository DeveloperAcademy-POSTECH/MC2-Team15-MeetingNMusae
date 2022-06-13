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
                    Button {
                        print("방 만들어줘라!!")
                    } label: {
                        NavigationLink(destination: RoomFindingView()) {
                            SelectBox(isDark: true, discription: "방 만들기")
                        }
                    }// Button_RoomFindingView
                    Button {
                        print("입장을 할 것이다!! ")
                    }label: {
                        NavigationLink(destination: NicknameSettingView()) {
                            SelectBox(isDark: false, discription: "입장하기")
                        }
                    }// Button_Enterence
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

struct SelectBox: View {
    let isDark: Bool
    var discription: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(isDark ? .black : .white)
            Text(discription)
                .font(.system(size: 18))
                .foregroundColor(isDark ? .white : .black)
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 3)
            
        }
        .frame(height: 65)
        .padding(.horizontal, 24)
        
    }
}

