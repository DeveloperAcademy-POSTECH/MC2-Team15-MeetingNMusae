//
//  NicknameSettingView.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/13.
//

import SwiftUI

struct NicknameSettingView: View {
    @State var nickName: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            Text("닉네임을 입력해주세요")
                .font(.custom("Apple SD Gothic Neo", size: 24))
                .fontWeight(.bold)
            TextInputBox(textInput: $nickName, description: "한/영 4글자", textLimit: 4)
            Spacer()
            HStack {
                Spacer()
                CircleButton(text: $nickName)
            }// HStack
        }// VStack
        .padding(28)
    }
}

struct NicknameSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NicknameSettingView()
    }
}
