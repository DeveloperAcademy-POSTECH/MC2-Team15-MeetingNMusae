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
    @ObservedObject var userViewModel = UserViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // TODO: Component를 만들 예정
            Text("랜덤 피드백!")
            Text("모두가 피드백을 받을 수 있도록")
            Text("한 마디를 써주세요")
            // MARK: 이거 왜 이미지 크기 이상함?
            // TODO: firstore 에서 가져오기
            ForEach(self.reviewViewModel.reviews) { review in
                Image("주제무새")
                    .resizable()
                    .frame(width: 118, height: 118)
                // TODO: frame to padding
                VStack(alignment: .leading) {
                    // TODO: firstore 에서 가져오기
                    NameBox(user: review.to)
                    // TODO: 버튼위에 딱 맞추기
                    TextField("OO해서 회의에 도움이 되었어요!", text: $content)
                        .font(Font.headline.weight(.bold))
                    Spacer()
                }
                .padding()
                .frame(width: 311, height: 173)
                .background(CharacterBox())
                .padding(.bottom, 180)
            }
            Button {
                self.reviewViewModel.addReview(review: Review(content: content, from: from, to: to, roomCode: roomCode))
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
                Spacer()
                
            }
            .onAppear {
                self.reviewViewModel.getReviewee(roomCode: self.roomCode, nickname: self.nickname)
                self.userViewModel.fetchData(roomCode: self.roomCode)
            }
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
