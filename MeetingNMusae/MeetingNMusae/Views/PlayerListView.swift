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
    @Environment(\.presentationMode) private var presentationMode

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
                    .padding(.top, 15)
                    .padding(.bottom, 22)
                    .textSelection(.enabled)
                HStack {
                    Button(action: {
                        // Home으로 나가기
                        presentationMode.wrappedValue.dismiss()
                        userViewModel.deleteMeetingRoom(roomCode: roomCode, nickname: UserDefaults.standard.string(forKey: "nickname") ?? "")
                    }, label: {
                        Image("나가기")
                            .resizable()
                            .frame(width: UIScreen.screenWidth * 0.0718, height: UIScreen.screenWidth * 0.0718)
                            .offset(x: -4, y: 0)
                    })
                    Spacer()
                }
                .padding(.leading, 24)
            }// ZStack_RoomCodeBox
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("참여자 (\(userViewModel.users.count))")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .padding(.all, UIScreen.screenHeight * 0.0284)
                    Image("dotted_line")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
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
                .padding(.leading, UIScreen.screenWidth * 0.0718)
                .padding(.trailing, UIScreen.screenWidth * 0.0924)

                if userViewModel.users.count < 3 {
                    HStack {
                        Text("최소 3명의 인원이 필요합니다.")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(.subTextGray)
                            .padding(.top, 20)
                        Spacer()
                    }
                    .padding(.leading, UIScreen.screenWidth * 0.0718 + 6)
                    Spacer()
                } else if isOwner {
                    Spacer()
                    Button {
                        MeetingRoomViewModel().startMeeting(roomCode: roomCode)
                    } label: {
                        SelectBox(isDark: true, description: "회의 시작")
                    }
                } else {
                    HStack {
                        Text("방장의 시작을 기다리는 중입니다.")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(.subTextGray)
                            .padding(.top, 20)
                        Spacer()
                    }
                    .padding(.leading, UIScreen.screenWidth * 0.0718 + 6)
                    Spacer()
                }
            }// VStack
        }
        .navigationBarHidden(true)
    }

}
