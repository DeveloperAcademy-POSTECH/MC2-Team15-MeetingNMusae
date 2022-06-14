//
//  NicknameSettingView.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/13.
//

import SwiftUI

struct NicknameSettingView: View {
    @State var nickname: String = ""
    let nicknameUpperLimit: Int = 4
    
    func isTextEmpty(text: String) -> Bool {
        if text.count == self.nicknameUpperLimit {
            return false
        } else {
            return true
        }
    }// isTextEmpty
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("닉네임을 입력해주세요")
                .font(.custom("Apple SD Gothic Neo", size: 24))
                .fontWeight(.bold)
            TextInputBox(textInput: $nickname, description: "한/영 4글자", textLimit: 4)
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: NicknameSettingView()) {
                    CircleButton(text: $nickname, upperLimit: nicknameUpperLimit)
                }
                .simultaneousGesture(TapGesture()
                    .onEnded {
                        UserDefaults.standard.set(self.nickname, forKey: "nickname")
                    }
                )
                .disabled(isTextEmpty(text: nickname))
            }// HStack
        }// VStack
        .padding([.leading, .bottom, .trailing], 28)
    }
}

struct NicknameSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NicknameSettingView()
    }
}
