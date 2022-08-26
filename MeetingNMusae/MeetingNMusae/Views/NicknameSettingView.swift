//
//  NicknameSettingView.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/13.
//

import SwiftUI

struct NicknameSettingView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var roomCode: String
    @State var nickname: String = ""
    @State var isNicknameExist: Bool = false
    var isOwner: Bool
    let nicknameUpperLimit: Int = 4
    
    private func isTextEmpty(text: String) -> Bool {
        if text.count >= 1 {
            return false
        } else {
            return true
        }
    }// isTextEmpty
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.backward")
                        .font(.system(size: 18, weight: .semibold))
                        .padding(.bottom)
                        .tint(.black)
                })
            }// HStack_BackButton
            Text("닉네임을 입력해주세요")
                .font(.custom("Apple SD Gothic Neo", size: 24))
                .fontWeight(.bold)
            TextInputBox(textInput: $nickname, description: "한/영 4글자", textLimit: nicknameUpperLimit)
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: SwitchView(roomCode: roomCode, isOwner: isOwner)) {
                    CircleButton(text: $nickname, isExist: $isNicknameExist, upperLimit: 1)
                }
                .simultaneousGesture(TapGesture()
                    .onEnded {
                        UserDefaults.standard.set(self.nickname, forKey: "nickname")
                        
                        let user: User = User(missionIds: [0, 1, 2], nickname: nickname, roomCode: roomCode)
                        
                        if isOwner {
                            MeetingRoomViewModel().addMeetingRoom(meetingRoom: MeetingRoom(owner: nickname, roomCode: roomCode))
                        }
                        UserViewModel().addUser(roomCode: roomCode, user: user)
                    }
                )
                .disabled(isTextEmpty(text: nickname))
            }// HStack
        }// VStack
        .navigationTitle("")
        .padding(28)
        .navigationBarHidden(true)
    }
}
