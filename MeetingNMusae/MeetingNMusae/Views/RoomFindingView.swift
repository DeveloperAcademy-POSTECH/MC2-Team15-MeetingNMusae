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
    let textUpperLimit: Int = 6
    
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
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: NicknameSettingView(isRootActive: $isRootActive, roomCode: roomCode, isOwner: false)) {
                    CircleButton(text: $roomCode, upperLimit: 6)
                }
                .simultaneousGesture(TapGesture()
                    .onEnded {
                        UserDefaults.standard.set(self.roomCode, forKey: "roomCode")
                    }
                )
                .disabled(isTextEmpty(text: roomCode))
            }// HStack_CircleButton
        }// VStack
        .navigationTitle("")
        .padding(28)
        .navigationBarHidden(true)
    }
}
