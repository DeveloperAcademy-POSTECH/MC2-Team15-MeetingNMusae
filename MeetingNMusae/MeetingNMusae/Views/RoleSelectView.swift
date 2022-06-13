//
//  RoleSelectView.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//

import SwiftUI
import FirebaseFirestore

let imageWidthSize: CGFloat = 128
let imageHeightSize: CGFloat = 86

struct RoleSelectView: View {
    @State var columns: [GridItem] = [
        GridItem(),
        GridItem()
    ]
    @State var roomCode: String
    @State var roles: [Role] = Role.roles
    @State var user: User
    @ObservedObject var meetingRoomViewModel = MeetingRoomViewModel()
    private var db = Firestore.firestore()
    init(roomCode: String, nickname: String) {
        self.roomCode = roomCode
        self.user = User(missionIds: [0, 1, 2], nickname: nickname, roomCode: roomCode)
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text("역할을 골라주세요").font(.headline).padding(.leading)
            HStack {
                Image(systemName: "star.circle.fill")
                Text("필수 역할입니다")
            }
            .padding(.leading)
            .font(.subheadline)
            .foregroundColor(Color.gray)
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(meetingRoomViewModel.meetingRooms) { meetingRoom in
                        ForEach(0..<roles.count, id: \.self) { i in
                            RoleItem(role: roles[i], roleSelectUser: meetingRoom.roleSelectUsers[i], roomCode: roomCode, nickname: user.nickname)
                        }
                    }
                }.onAppear {
                    self.meetingRoomViewModel.fetchData(roomCode: roomCode)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    // todo
                    // 방 선택뷰로 이동하는 기능
                }, label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right").rotationEffect(.degrees(180))
                })
                .foregroundColor(.black)
            }
        }
    }
}

struct RoleItem: View {
    @State var isModalShown = false
    @State var role: Role
    @State var roleSelectUser: String
    @State var roomCode: String
    @State var nickname: String
    var body: some View {
        Button {
            isModalShown = true
        } label: {
            ZStack {
                if roleSelectUser != "" {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black)
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.yellow)
                }
                VStack {
                    Image("\(role.roleName)")
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageWidthSize, height: imageHeightSize)
                    Text("\(role.roleName)").padding(.bottom).foregroundColor(.black)
                }
                VStack {
                    HStack {
                        if role.id <= 3 {
                            Image(systemName: "star.circle.fill")
                        }
                        Text("\(roleSelectUser)")
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 20.0).fill(Color.black))
                        Spacer()
                    }.foregroundColor(Color.black)
                        .padding(10)
                    Spacer()
                }
            }
        }.sheet(isPresented: $isModalShown) {
            NavigationView {
                RoleDetailView(role: role, roomCode: roomCode, nickname: nickname, isModalShown: $isModalShown)
            }
        }
        .padding(.leading)
        .padding(.trailing)
    }
}
