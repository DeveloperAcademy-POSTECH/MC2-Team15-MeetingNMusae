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

            Button(action: {
                // todo
                // 유저를 meeting_rooms의 room_code에 해당하는 users에 추가해야함
            }, label: {
                Text("입장하기")
            })
        }
    }
}
