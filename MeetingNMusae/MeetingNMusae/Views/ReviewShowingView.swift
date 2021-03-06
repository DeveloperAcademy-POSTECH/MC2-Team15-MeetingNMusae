//
//  ReviewShowingView.swift
//  MeetingNMusae
//
//  Created by 김태호 on 2022/06/17.
//

import SwiftUI

struct ReviewShowingView: View {
    //    roleIndex를 받아와서 ReviewBox에 넣어주시면 됩니다
    @ObservedObject var reviewViewModel = ReviewViewModel()
    @ObservedObject var meetingRoomViewModel = MeetingRoomViewModel()
    @ObservedObject var userViewModel = UserViewModel()
    @State var roomCode: String
    @State var nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
    
    var body: some View {
        VStack {
            TitleBox(description: "무새가 무새에게")
                .padding(.bottom, 28)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(reviewViewModel.reviews) { review in
                        ReviewBox(user: review.to, role: Role.roles[review.revieweeRoleId].roleName, review: review.content, roleIndex: review.revieweeRoleId)
                    }
                }
            }
            .onAppear {
                reviewViewModel.fetchData(roomCode: roomCode)
                meetingRoomViewModel.getUsersCount(roomCode: roomCode)
            }
            
            Button(action: {
                userViewModel.deleteMeetingRoom(roomCode: roomCode, nickname: nickname)
                if meetingRoomViewModel.usersCount == 1 {
                    meetingRoomViewModel.deleteMeetingRoom(roomCode: roomCode)
                }
                reviewViewModel.deleteReviews(roomCode: roomCode)
                // home으로
                UserDefaults.standard.set(0, forKey: "roleId")
                UserDefaults.standard.set("", forKey: "nickname")
                UserDefaults.standard.set("", forKey: "roomCode")
            }, label: {
                SelectBox(isDark: true, description: "나가기")
                    .padding(.top)
            })
            
            Spacer()
        }
    }
}
