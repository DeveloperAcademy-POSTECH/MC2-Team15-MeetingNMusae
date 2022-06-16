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
    @State var reviews: [Review] = []
    @State var to: String = ""
    @State var from: String = ""
    @State var content: String = ""
    @ObservedObject var reviewViewModel = ReviewViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("랜덤 피드백!")
                .font(.system(size: 24))
                .fontWeight(.heavy)
                .padding(.top, UIScreen.screenHeight * 0.0332)
                .padding(.bottom, UIScreen.screenHeight * 0.0095)
            Text("모두가 피드백을 받을 수 있도록\n한 마디를 써주세요")
                .font(.system(size: 16))
                .fontWeight(.medium)
                .foregroundColor(Color(hex: "6C6C6C"))
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
            ForEach(self.reviewViewModel.reviews) { review in
                Image(Role.roles[review.revieweeRoleId - 1].roleName + "_피드백작성")
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 8) {
                        NameBox(user: review.to)
                        Text(Role.roles[review.revieweeRoleId - 1].roleName)
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                    }
                    TextField("OO해서 회의에 도움이 되었어요!", text: $content)
                        .font(.system(size: 16))
                    Spacer()
                }
                .padding(28)
                .frame(width: 326, height: 144)
                .background(CharacterBox())
                .padding(.bottom, 180)
            }
            Button {
                self.reviewViewModel.addReview(review: Review(content: content, from: from, to: to, roomCode: roomCode, revieweeRoleId: 2))
                content = ""
                to = ""
                from = ""
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 64)
                        .foregroundColor(.black)
                    Text("작성 완료")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            Spacer()
        }
        .onAppear {
            self.reviewViewModel.getReviewee(roomCode: self.roomCode, nickname: self.nickname)
        }
    }
    
    func action() {
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
