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
    
    private func MakeRoomCode() {
        let str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        self.roomCode = ""
        for _ in 0..<6 {
            guard let randomCharacter = str.randomElement() else { break }
            roomCode.append(randomCharacter)
        }
        
        for storeRoomCode in meetingRoomViewModel.roomCodeList where self.roomCode == storeRoomCode {
            MakeRoomCode()
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("회의하는 N무새")
                    . font(.title)
                    .fontWeight(.heavy)
                    .padding(.bottom, 46)
                Image("회의하는N무새")
                    .frame(width: 360, height: 360)
                    .padding(.bottom, 88)
                VStack(alignment: .center, spacing: 20) {
                    NavigationLink(destination: NicknameSettingView(roomCode: roomCode, isOwner: true)) {
                        SelectBox(isDark: true, description: "방 만들기")
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        MakeRoomCode()
                        UserDefaults.standard.set(self.roomCode, forKey: "roomCode")
                    })
                    NavigationLink(destination: RoomFindingView()) {
                        SelectBox(isDark: false, description: "입장하기")
                    }
                }// VStack
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top)
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

