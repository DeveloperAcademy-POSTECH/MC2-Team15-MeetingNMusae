//
//  Home.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/13.
//

import SwiftUI

struct Home: View {
    @State var roomCode: String = ""
    @ObservedObject var meetingRoomViewModel = MeetingRoomViewModel()
    
    @State var isNicknameSettingViewActive: Bool = false
    @State var isRoomFindingViewActive: Bool = false

    private let imageHeight = UIScreen.screenHeight * 0.4265
    private let imageWidth = UIScreen.screenWidth * 0.923
    private let buttonSpacing = UIScreen.screenHeight * 0.019
    private let titleTopPadding = UIScreen.screenHeight * 0.114
    private let titleBottomPadding = UIScreen.screenHeight * 0.057

    private func makeRoomCode() {
        let str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        self.roomCode = ""
        for _ in 0..<6 {
            guard let randomCharacter = str.randomElement() else { break }
            roomCode.append(randomCharacter)
        }
        
        for storeRoomCode in meetingRoomViewModel.roomCodeList where self.roomCode == storeRoomCode {
            makeRoomCode()
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Text("회의하는 N무새")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding(.top, titleTopPadding)
                    .padding(.bottom, titleBottomPadding)
                Image("회의하는N무새")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageWidth, height: imageHeight)
                    .padding(.bottom, UIScreen.screenHeight * 0.1)
                VStack(spacing: buttonSpacing) {
                    NavigationLink(destination: NicknameSettingView(isRootActive: $isNicknameSettingViewActive, roomCode: roomCode, isOwner: true), isActive: self.$isNicknameSettingViewActive) {
                        SelectBox(isDark: true, description: "방 만들기")
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        makeRoomCode()
                        UserDefaults.standard.set(self.roomCode, forKey: "roomCode")
                    })
                    NavigationLink(destination: RoomFindingView(isRootActive: $isRoomFindingViewActive), isActive: self.$isRoomFindingViewActive) {
                        SelectBox(isDark: false, description: "입장하기")
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                self.meetingRoomViewModel.getRoomCodeList()
            }
        }// NavigationView
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

