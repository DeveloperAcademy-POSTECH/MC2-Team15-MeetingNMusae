//
//  ReviewView.swift
//  MeetingNMusae
//
//  Created by taekkim on 2022/06/09.
//

import SwiftUI

struct ReviewWritingView: View {

    let roomCode: String
    @State var reviews: [Review] = []
    @State var to: String = ""
    @State var from: String = ""
    @State var content: String = ""
//    let reviewee1: Review = Review(content: "짱 좋아요", from: "Cozy", to: "Woogy", roomCode: "971015")
//    let reviewee2: Review = Review(content: "짱 안 좋아요", from: "Nick", to: "Cozy", roomCode: "971015")
    @ObservedObject var reviewViewModel = ReviewViewModel()

    var body: some View {
        VStack {
            TextField("누가", text: $from)
            TextField("누구에게", text: $to)
            TextField("내용", text: $content)
            Button {
                self.reviewViewModel.addReview(review: Review(content: content, from: from, to: to, roomCode: roomCode))
                content = ""
                to = ""
                from = ""
            } label: { Text("제출") }
            ForEach(reviewViewModel.reviews) { review in
                Text(review.roomCode)
            }
        }
        .onAppear {
            self.reviewViewModel.fetchData(roomCode: self.roomCode)
        }
    }

    func action() {
    }
}

struct ReviewWritingView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewWritingView(roomCode: "BHWK43")
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
