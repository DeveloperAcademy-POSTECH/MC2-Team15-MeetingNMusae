//
//  ReviewShowingView.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/17.
//

import SwiftUI

struct ReviewShowingView: View {
    @ObservedObject var reviewViewModel: ReviewViewModel = ReviewViewModel()
    @ObservedObject var meetingRoomViewModel: MeetingRoomViewModel = MeetingRoomViewModel()
    @ObservedObject var userViewModel: UserViewModel = UserViewModel()
    @State var roomCode: String
    @State var nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
    @Binding var isRootActive: Bool

    var body: some View {
        VStack {
            TitleBox(description: "무새가 무새에게")
                .padding(.bottom, 28)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(reviewViewModel.reviews) { review in
                        if review.content != "" {
                            ReviewBox(user: review.to, role: Role.roles[review.revieweeRoleId - 1].roleName, review: review.content, roleIndex: review.revieweeRoleId)
                        }
                    }
                }
                .frame(width: UIScreen.screenWidth)
                .padding(.top, 5)
            }
            .onAppear {
                reviewViewModel.fetchData(roomCode: roomCode)
                meetingRoomViewModel.getUsersCount(roomCode: roomCode)
            }
            
            Button(action: {
                userViewModel.deleteMeetingRoom(roomCode: roomCode, nickname: nickname)
                if meetingRoomViewModel.usersCount == 1 {
                    meetingRoomViewModel.deleteMeetingRoom(roomCode: roomCode)
                    reviewViewModel.deleteReviews(roomCode: roomCode)
                }
                // home으로
                UserDefaults.standard.set(0, forKey: "roleId")
                UserDefaults.standard.set("", forKey: "nickname")
                UserDefaults.standard.set("", forKey: "roomCode")
                isRootActive = false
            }, label: {
                SelectBox(isDark: true, description: "나가기")
                    .padding(.top)
            })
        }
        .navigationBarHidden(true)
    }
}
