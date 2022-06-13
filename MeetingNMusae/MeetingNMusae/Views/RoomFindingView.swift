//
//  RoomFindingView.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/13.
//

import SwiftUI

struct RoomFindingView: View {
    @State var roomCode: String
    @State var isRoomCodeEmpty: Bool
    
    init(roomCode: String = "", isRoomCodeEmpty: Bool = false) {
        self.roomCode = roomCode
        self.isRoomCodeEmpty = isRoomCodeEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("방 코드를 입력해주세요")
                .font(.custom("Apple SD Gothic Neo", size: 24))
                .fontWeight(.bold)
            TextInputBox(textInput: $roomCode, description: "방코드 6자", textLimit: 6)
            Spacer()
            HStack {
                Spacer()
                Button { print("닉네임 입력으로") } label: {
                    //                    NavigationLink
                    CircleButton(text: $roomCode)
                }
                .disabled(isRoomCodeEmpty)
            }// HStack
        }// VStack
        .padding(28)
    }
}

struct RoomFindingView_Previews: PreviewProvider {
    static var previews: some View {
        RoomFindingView()
    }
}
