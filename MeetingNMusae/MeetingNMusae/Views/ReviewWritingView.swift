//
//  ReviewView.swift
//  MeetingNMusae
//
//  Created by taekkim on 2022/06/09.
//

import SwiftUI


struct ReviewWritingView: View {
    
    let roomCode: String
    let nickname: String
    @State private var content: String = ""
    @ObservedObject var reviewViewModel = ReviewViewModel()
    @FocusState private var isTextFieldFocused: Bool
    @State private var to: String? = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(spacing: 0) {
                Text("랜덤 피드백!")
                    .font(.system(size: 24))
                    .fontWeight(.heavy)
                    .padding(.top, UIScreen.screenHeight * 0.0332)
                    .padding(.bottom, UIScreen.screenHeight * 0.0095)
                Text("모두가 피드백을 받을 수 있도록\n한 마디를 써주세요")
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .lineSpacing(2.2)
                    .foregroundColor(Color(hex: "6C6C6C"))
                    .multilineTextAlignment(.center)
                    .frame(height: 41)
                    .padding(.bottom, 8)
                ForEach(self.reviewViewModel.reviews) { review in
                    Image(Role.roles[review.revieweeRoleId - 1].roleName + "_피드백작성")
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 8) {
                            Text(review.to)
                                .bold()
                                .padding(4)
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 6.0).fill(Color.black))
                            Text(Role.roles[review.revieweeRoleId - 1].roleName)
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                        }
                        MultiLineTextField()
                            .focused($isTextFieldFocused)
                    }
                    .padding(28)
                    .frame(width: 326, height: 144)
                    .background(CharacterBox())
                }
            }
            Spacer()
            NavigationLink(destination:
                            NavigationView { ReviewShowingView() } ) {
                ZStack {
                    Rectangle()
                        .frame(height: 64)
                        .foregroundColor(.black)
                        .cornerRadius(isTextFieldFocused ? 0 : 12)
                    Text("작성 완료")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .simultaneousGesture(TapGesture()
                .onEnded {
                    print("bye")
                    ////                    guard !content.isEmpty else { return }
                    ////                    UserDefaults.standard.set(self.nickname, forKey: "nickname")
                    ////
                    ////                    let user: User = User(missionIds: [0, 1, 2], nickname: nickname, roomCode: roomCode)
                    ////
                    ////                    if isOwner {
                    ////                        MeetingRoomViewModel().addMeetingRoom(meetingRoom: MeetingRoom(owner: nickname, roomCode: roomCode))
                    ////                    }
                    ////                    UserViewModel().addUser(roomCode: roomCode, user: user)
                }
            )
            ////            .disabled(isTextEmpty(text: nickname))
            .frame(width: isTextFieldFocused ? nil : 334)
        }
        .onAppear {
            self.reviewViewModel.getReviewee(roomCode: self.roomCode, nickname: self.nickname)
        }
    }
    
    private struct MultiLineTextField: View {
        @State private var text: String = ""
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

struct ReviewWritingView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewWritingView(roomCode: "1Q2W3E", nickname: "Cozy")
        //        PlayerListView(roomCode: "9MCMPK")
        //            .previewDevice("iPhone 13 (mini)")
        //        PlayerListView(roomCode: "9MCMPK")
        //            .previewDevice("iPhone 13 Pro Max")
        //        PlayerListView(roomCode: "9MCMPK")
        //            .previewDevice("iPhone 13")
        //        PlayerListView(roomCode: "9MCMPK")
        //            .previewDevice("iPad Air (5th generation)")
    }
}
