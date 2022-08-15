//
//  PlayerListView.swift
//  MeetingNMusae
//
//  Created by taekkim on 2022/06/09.
//

import SwiftUI

struct PlayerListView: View {

    let roomCode: String
    let isOwner: Bool
    let nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
    @State var users: [User] = []
    
    @ObservedObject var userViewModel = UserViewModel()
    
    init(roomCode: String, isOwner: Bool) {
        self.roomCode = roomCode
        self.isOwner = isOwner
        self.userViewModel.fetchData(roomCode: roomCode)
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text(roomCode)
                    .fontWeight(.bold)
                    .padding(.vertical, UIScreen.screenHeight * 0.0237)
                HStack {
                    Button(action: {
                        // Home으로 나가기
                        userViewModel.deleteMeetingRoom(roomCode: roomCode, nickname: UserDefaults.standard.string(forKey: "nickname") ?? "")
                    }, label: {
                        Image("나가기")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .offset(x: -4, y: 0)
                    })
                    Spacer()
                }
            }// ZStack_RoomCodeBox
            .overlay(alignment: .leading) {
                
            }
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("참여자 (\(userViewModel.users.count))")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .padding(.all, UIScreen.screenHeight * 0.0284)
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 3, dash: [10]))
                        .frame(height: 1)
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(userViewModel.users) { user in
                            Text("• " + user.nickname)
                                .fontWeight(.bold)
                                .padding(.all, UIScreen.screenHeight * 0.0178)
                        }
                    }
                    .padding(.all, UIScreen.screenHeight * 0.0178)
                }
                .background(CharacterBox())
                Spacer()
                
                if isOwner {
                    Button(action: {
                        MeetingRoomViewModel().startMeeting(roomCode: roomCode)
                        
                        var reviewee: String!
                        var revieweeRoleId: Int!
                        if userViewModel.users.count == 1 {
                            reviewee = nickname
                            revieweeRoleId = 0
                        } else {
                            for (idx, user) in userViewModel.users.enumerated() {
                                if user.nickname == nickname {
                                    reviewee = userViewModel.users[Date.getRevieweeIndex(index: idx, num: userViewModel.users.count)].nickname
                                    revieweeRoleId = userViewModel.users[Date.getRevieweeIndex(index: idx, num: userViewModel.users.count)].roleId
                                }
                            }
                        }
                        
                        // todo
                        let review: Review = Review(content: "", from: nickname, to: reviewee, roomCode: roomCode, revieweeRoleId: revieweeRoleId)
                        ReviewViewModel().setReviewee(roomCode: roomCode, nickname: nickname, review: review)
                        
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.black)
                            Text("회의 시작")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .frame(height: UIScreen.screenHeight * 0.076)
                    })
                    .padding(.bottom, 8)
                } else {
                    EmptyView()
                }
            }
        }// VStack
        .frame(width: UIScreen.screenWidth * 0.84)
        .navigationBarHidden(true)
    }
}
