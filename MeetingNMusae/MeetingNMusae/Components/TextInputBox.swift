//
//  TextInputBox.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/13.
//

import SwiftUI
import Combine

struct TextInputBox: View {
    @Binding var textInput: String
    let description: String
    var textLimit: Int
    
    // 입력 글자수 제한
    func LimitText(_ upper: Int) {
        if textInput.count >= upper {
            textInput = String(textInput.prefix(upper))
        }
    } // limitText
    
    var body: some View {
        HStack {
            CharacterBox(width: 137, height: 56)
                .overlay(
                    TextField(description, text: $textInput)
                        .font(.system(size: 18, weight: .bold))
                        .padding(.horizontal, 20)
                        .autocapitalization(UITextAutocapitalizationType.allCharacters)
                        // cozytk
                        .onChange(of: textInput) { newValue in
                            textInput = newValue.replacingOccurrences(of: " ", with: "")
                        }
                        .onReceive(Just(textInput),
                                   perform: {_ in LimitText(textLimit)}
                                  )
                )
            Spacer()
        }
    }
}
