//
//  HomeView.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/11.
//

import SwiftUI

struct HomeView: View {
    @State var roomCode: String = ""
    @State var nickname: String = ""

    var body: some View {
        VStack {
            TextField("nickname을 입력하세요", text: $nickname)
            TextField("room code를 입력하세요", text: $roomCode)

            Button(action: {
                let str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
                roomCode = ""

                for _ in 0..<6 {
                    guard let randomCharacter = str.randomElement() else { break }
                    roomCode.append(randomCharacter)
                }
            }, label: {
                Text("방 만들기")
            })
            
            NavigationLink(destination: RoleSelectView(roomCode: roomCode, nickname: nickname)) {
                Text("입장하기")
            }.simultaneousGesture(TapGesture().onEnded{
                let user: User = User(missionIds: [0, 1, 2], nickname: nickname, roomCode: roomCode)
                UserViewModel().addUser(roomCode: roomCode, user: user)
            })
        }
        .navigationBarHidden(true)
    }
}
