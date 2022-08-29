//
//  ReviewView.swift
//  MeetingNMusae
//
//  Created by taekkim on 2022/06/09.
//
import SwiftUI


struct ReviewWritingView: View {
    let roomCode: String
    @Binding var isReviewFinished: Bool
    let nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
    @State var content: String = ""
    @ObservedObject var reviewViewModel = ReviewViewModel()
    @FocusState private var isTextFieldFocused: Bool
    @State private var to: String? = ""

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(spacing: 0) {
                Text("랜덤 피드백!")
                    .font(.system(size: UIScreen.screenHeight * 0.028))
                    .fontWeight(.heavy)
                    .padding(.top, UIScreen.screenHeight * 0.0237)
                    .padding(.bottom, UIScreen.screenHeight * 0.0095)
                Text("모두가 피드백을 받을 수 있도록\n한 마디를 써주세요")
                    .font(.system(size: UIScreen.screenHeight * 0.019))
                    .fontWeight(.medium)
                    .lineSpacing(2.2)
                    .foregroundColor(.subTextGray)
                    .multilineTextAlignment(.center)
                ForEach(self.reviewViewModel.reviews) { review in
                    VStack(spacing: 0) {
                        Image("\(Role.roles[review.revieweeRoleId - 1].roleName)_피드백작성")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: UIScreen.screenHeight * 0.148)
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 8) {
                                NameBox(user: review.to)
                                Text(Role.roles[review.revieweeRoleId - 1].roleName)
                                    .font(.system(size: 17))
                                    .fontWeight(.bold)
                            }
                            MultiLineTextField(text: $content)
                                .focused($isTextFieldFocused)
                        }
                        .padding(.all, UIScreen.screenHeight * 0.033)
                        .background(CharacterBox())
                        .frame(maxHeight: UIScreen.screenHeight * 0.21)
                        .padding(.horizontal, UIScreen.screenWidth * 0.0718)
                        .padding(.trailing, UIScreen.screenWidth * 0.0205)
                    }
                }
                .padding(.bottom, 8)
            }
            Spacer()
            if isTextFieldFocused {
                ZStack {
                    Rectangle()
                        .frame(height: UIScreen.screenHeight * 0.076)
                        .foregroundColor(.black)
                        .cornerRadius(0)
                    Text("작성 완료")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .frame(width: nil)
                .simultaneousGesture(TapGesture()
                    .onEnded {
                        reviewViewModel.setReviewContent(roomCode: roomCode, nickname: nickname, content: content)
                        isReviewFinished = true
                    }
                )
            } else {
                SelectBox(isDark: true, description: "작성 완료")
                .simultaneousGesture(TapGesture()
                    .onEnded {
                        reviewViewModel.setReviewContent(roomCode: roomCode, nickname: nickname, content: content)
                        isReviewFinished = true
                    }
                )
            }
        }
        .onAppear {
            self.reviewViewModel.getReviewee(roomCode: self.roomCode, nickname: self.nickname)
        }
    }

    
    private struct MultiLineTextField: View {
        @Binding var text: String
        private let placeHolder: String = "OO해서 도움이 되었습니다!"
        
        var body: some View {
            VStack(spacing: 0) {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: .constant(placeHolder))
                        .font(.system(size: 16))
                        .disabled(true)
                    TextEditor(text: $text)
                        .font(.system(size: 16))
                        .opacity(text == "" ? 0.7 : 1)
                }
            }
        }
    }
}
