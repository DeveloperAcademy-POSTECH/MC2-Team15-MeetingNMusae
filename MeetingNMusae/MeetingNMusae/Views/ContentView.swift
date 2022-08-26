//
//  ContentView.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//

import SwiftUI

struct ContentView: View {
    //    let roomCode: String
    //    @State var isReviewFinished = false
    let nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
    @State var content: String = ""
    @ObservedObject var reviewViewModel = ReviewViewModel()
    @FocusState private var isTextFieldFocused: Bool
    @State private var to: String? = ""

    var body: some View {
        VStack(alignment: .center) {
            VStack(spacing: 0) {
                Text("랜덤 피드백!")
                    .font(.system(size: 24))
                    .fontWeight(.heavy)
                    .padding(.top, UIScreen.screenHeight * 0.0237)
                    .padding(.bottom, UIScreen.screenHeight * 0.0095)
                Text("모두가 피드백을 받을 수 있도록\n한 마디를 써주세요")
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .lineSpacing(2.2)
                    .foregroundColor(Color(hex: "6C6C6C"))
                    .multilineTextAlignment(.center)
                    .frame(height: 41)
                    .padding(.bottom, UIScreen.screenHeight * 0.005)
                Image("진행무새_피드백작성")
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        Text("우기")
                            .bold()
                            .padding(4)
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 6.0).fill(Color.black))
                        Text("기록무새")
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                    }
                    MultiLineTextField(text: $content)
                        .focused($isTextFieldFocused)
                }
                .padding(28)
                .background(CharacterBox())
                .padding(.horizontal, 28)
                .padding(.trailing, 8)
//                .frame(height: 144)
            }
            Spacer()
//                .frame(minWidth: 150s)
            if isTextFieldFocused {
                ZStack {
                    Rectangle()
                        .frame(height: 64)
                        .foregroundColor(.black)
                        .cornerRadius(0)
                    Text("작성 완료")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .frame(width: nil)
            } else {
                ZStack {
                    Rectangle()
                        .frame(height: 64)
                        .foregroundColor(.black)
                        .cornerRadius(12)
                    Text("작성 완료")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .frame(width: 334)
            }
        }
    }

    private class KeyboardHeightHelper: ObservableObject {

        init() {
            self.listenForKeyboardNotifications()
        }

        @Published var keyboardHeight: CGFloat = 0
        private func listenForKeyboardNotifications() {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification,
                                                   object: nil,
                                                   queue: .main) { (notification) in
                guard let userInfo = notification.userInfo,
                      let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

                self.keyboardHeight = keyboardRect.height
            }

            NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification,
                                                   object: nil,
                                                   queue: .main) { (notification) in
                self.keyboardHeight = 0
            }
        }

    }

    private struct MultiLineTextField: View {
        @Binding var text: String
//        @Binding var boxHeight: CGFloat
        private let placeHolder: String = "OO해서 도움이 되었습니다!"

        var body: some View {
            ZStack(alignment: .topLeading) {
                TextEditor(text: .constant(placeHolder))
                    .font(.system(size: 16))
                    .disabled(true)
                TextEditor(text: $text)
                    .font(.system(size: 16))
                    .opacity(text == "" ? 0.7 : 1)
//                    .readSize(onChange: { viewSize in
//                        print(viewSize)
//                        boxHeight = min(190.0, max(140.0, viewSize.height))
//                    })
            }
//            .frame(height: boxHeight)
        }
    }


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
