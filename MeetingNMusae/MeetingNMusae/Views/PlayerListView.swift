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
                    Button(action: action) {
                        Image("나가기")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .offset(x: -4, y: 0)
                    }
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
                    Button(action: action) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundColor(.black)
                            Text("회의 시작")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .frame(height: UIScreen.screenHeight * 0.076)
                    }
                    .padding(.bottom, 8)
                } else {
                    EmptyView()
                }
            }
        }// VStack
        .frame(width: UIScreen.screenWidth * 0.84)
        .navigationBarHidden(true)
    }

    func action() {
        MeetingRoomViewModel().startMeeting(roomCode: roomCode)
    }
}
