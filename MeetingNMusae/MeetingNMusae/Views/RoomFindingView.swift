//
//  RoomFindingView.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/13.
//

import SwiftUI

struct RoomFindingView: View {
    @Binding var isRootActive: Bool
    @Environment(\.presentationMode) var presentationMode
    @State var roomCode: String = ""
    @State var errorMessage: String = ""
    @State var isRoomcodeExist: Bool = false
    let textUpperLimit: Int = 6
    let meetingRoomViewModel = MeetingRoomViewModel()
    
    private func isTextEmpty(text: String) -> Bool {
        if text.count == self.textUpperLimit {
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
            Text("방 코드를 입력해주세요")
                .font(.custom("Apple SD Gothic Neo", size: 24))
                .fontWeight(.bold)
                .padding(.bottom)
            TextInputBox(textInput: $roomCode, description: "방코드 6자", textLimit: textUpperLimit)
                .onChange(of: roomCode) { _ in
                    if roomCode.count == 6 {
                        meetingRoomViewModel.isExistedRoom(roomCode: roomCode) {
                            self.isRoomcodeExist = meetingRoomViewModel.isExistRoom
                            if !isRoomcodeExist {
                                errorMessage = "존재하지 않는 방 번호입니다."
                            }
                        }
                    } else {
                        errorMessage = ""
                    }
                }
            Text(errorMessage)
                .font(.callout)
                .fontWeight(.medium)
                .foregroundColor(.red)
                .padding(.top, 20)
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: NicknameSettingView(isRootActive: $isRootActive, roomCode: roomCode, isOwner: false)) {
                    CircleButton(text: $roomCode, isExist: $isRoomcodeExist, upperLimit: 6)
                }
                .simultaneousGesture(TapGesture()
                    .onEnded {
                        UserDefaults.standard.set(self.roomCode, forKey: "roomCode")
                    }
                )
                .disabled(isTextEmpty(text: roomCode) || !isRoomcodeExist)
            }// HStack_CircleButton
        }// VStack
        .navigationTitle("")
        .padding(28)
        .navigationBarHidden(true)
    }
}
