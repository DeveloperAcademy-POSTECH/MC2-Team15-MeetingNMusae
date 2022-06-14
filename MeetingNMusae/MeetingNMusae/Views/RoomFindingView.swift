//
//  RoomFindingView.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/13.
//

import SwiftUI

struct RoomFindingView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var roomCode: String = ""
    let textUpperLimit: Int = 6
    
    func isTextEmpty(text: String) -> Bool {
        if text.count == self.textUpperLimit {
            return false
        } else {
            return true
        }
    }// isTextEmpty
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("방 코드를 입력해주세요")
                .font(.custom("Apple SD Gothic Neo", size: 24))
                .fontWeight(.bold)
            TextInputBox(textInput: $roomCode, description: "방코드 6자", textLimit: 6)
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: NicknameSettingView()) {
                    CircleButton(text: $roomCode, upperLimit: 6)
                }
                .simultaneousGesture(TapGesture()
                    .onEnded {
                        UserDefaults.standard.set(self.roomCode, forKey: "roomCode")
                    }
                )
                .disabled(isTextEmpty(text: roomCode))
                
            }// HStack
        }// VStack
        .navigationTitle("")
        .padding([.leading, .bottom, .trailing], 28)
    }
}

struct RoomFindingView_Previews: PreviewProvider {
    static var previews: some View {
        RoomFindingView()
    }
}
