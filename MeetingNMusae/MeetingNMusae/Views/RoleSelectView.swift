//
//  RoleSelectView.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//

import SwiftUI
import FirebaseFirestore

struct RoleSelectView: View {
    @State var columns: [GridItem] = [
        GridItem(),
        GridItem()
    ]

    @State var roomCode = UserDefaults.standard.string(forKey: "roomCode") ?? ""
    @State var nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
    @State var roleId = UserDefaults.standard.integer(forKey: "roleId")

    @State var owner: String = ""
    @State var roles: [Role] = Role.roles
    @ObservedObject var meetingRoomViewModel = MeetingRoomViewModel()
    @ObservedObject var userViewModel = UserViewModel()

    private var db = Firestore.firestore()
    private let leadPadding = UIScreen.screenWidth * 0.03
    private let trailingPadding = UIScreen.screenWidth * 0.0923
    private let generalPadding = UIScreen.screenWidth * 0.0718

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("역할을 골라주세요").font(.title2).bold()
                .padding(EdgeInsets(top: generalPadding, leading: 0, bottom: 8, trailing: 0))

            HStack {
                Image(systemName: "star.circle.fill")
                Text("필수 역할입니다")
            }
            .padding(.bottom, generalPadding)
            .font(.subheadline)
            .foregroundColor(Color(hex: "6C6C6C"))

            ForEach(meetingRoomViewModel.meetingRooms) { meetingRoom in
                VStack {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(0..<roles.count, id: \.self) { i in
                                RoleItem(role: roles[i], roleSelectUser: meetingRoom.roleSelectUsers[i], roomCode: roomCode, meetingRoomViewModel: meetingRoomViewModel)
                                    .background(meetingRoom.roleSelectUsers[i] != "" ? CharacterBox(roleIndex: 0) : CharacterBox(roleIndex: roles[i].id))
                                    .padding(.leading, leadPadding)
                                    .padding(.bottom, generalPadding)
                            }
                        }
                        .padding(.top, 3)
                        .padding(.trailing, trailingPadding)
                    }
                    .padding(.leading, UIScreen.screenWidth * 0.04)

                    if meetingRoom.owner == nickname {
                        Button(action: {
                            if  meetingRoomViewModel.meetingRooms[0].roleSelectUsers.filter({ $0.count > 0 }).count == userViewModel.users.count, !(meetingRoomViewModel.meetingRooms[0].roleSelectUsers[0].isEmpty || meetingRoomViewModel.meetingRooms[0].roleSelectUsers[1].isEmpty || meetingRoomViewModel.meetingRooms[0].roleSelectUsers[2].isEmpty) {
                                meetingRoomViewModel.completedRoleSelect(roomCode: roomCode)

                                var reviewee: String!
                                var revieweeRoleId: Int!
                                if userViewModel.users.count == 1 {
                                    reviewee = nickname
                                    revieweeRoleId = 0
                                } else {
                                    for (idx, user) in userViewModel.users.enumerated() {
                                        reviewee = userViewModel.users[Date.getRevieweeIndex(userIndex: idx, totalUsers: userViewModel.users.count)].nickname
                                        revieweeRoleId = userViewModel.users[Date.getRevieweeIndex(userIndex: idx, totalUsers: userViewModel.users.count)].roleId
                                        let review: Review = Review(content: "", from: user.nickname, to: reviewee, roomCode: roomCode, revieweeRoleId: revieweeRoleId)
                                        ReviewViewModel().setReviewee(roomCode: roomCode, nickname: user.nickname, review: review)
                                    }
                                }
                            }
                        }, label: {
                            // nick의 SelectBox가 나오면 주석 해제
                            if meetingRoomViewModel.meetingRooms[0].roleSelectUsers.filter { $0.count > 0 }.count == userViewModel.users.count, !(meetingRoomViewModel.meetingRooms[0].roleSelectUsers[0].isEmpty || meetingRoomViewModel.meetingRooms[0].roleSelectUsers[1].isEmpty || meetingRoomViewModel.meetingRooms[0].roleSelectUsers[2].isEmpty) {
                                SelectBox(isDark: true, description: "선택 완료")
                            } else {
                                EmptyView()
                            }
                        })

                    } else {
                        EmptyView()
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            self.meetingRoomViewModel.fetchData(roomCode: roomCode)
            userViewModel.updateUserRole(roomCode: roomCode, roleId: roleId, nickname: nickname, isSelect: true)
            userViewModel.fetchData(roomCode: roomCode)
        }
    }
}

struct RoleItem: View {
    @State var isModalShown = false
    @State var role: Role
    @State var roleSelectUser: String
    var roomCode: String
    private let characterSize: CGFloat = UIScreen.screenHeight * 0.1422
    @ObservedObject var meetingRoomViewModel: MeetingRoomViewModel

    var body: some View {
        Button {
            isModalShown = true
        } label: {
            ZStack {
                VStack(spacing: 0) {
                    Image("\(role.roleName)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: characterSize)
                        .opacity(roleSelectUser == "" ? 1 : 0.5)
                        .padding(.top, 8)
                    Spacer()
                }

                VStack {
                    HStack {
                        if roleSelectUser == "" {
                            if role.id <= 3 {
                                Image(systemName: "star.circle.fill")
                                    .font(.system(size: 20))
                            }
                        } else {
                            NameBox(user: roleSelectUser)
                        }

                        Spacer()
                    }
                    .foregroundColor(Color.black)
                    .padding(10)

                    Spacer()
                    Text("\(role.roleName)")
                        .bold()
                        .padding(.bottom, 16)
                        .foregroundColor(.black)
                        .opacity(roleSelectUser == "" ? 1 : 0.5)
                }
            }
            .frame(width: UIScreen.screenWidth * 0.39, height: UIScreen.screenWidth * 0.41)

        }.sheet(isPresented: $isModalShown) {
            NavigationView {
                RoleDetailView(role: role, isModalShown: $isModalShown, meetingRoomViewModel: meetingRoomViewModel)
                    .ignoresSafeArea()
            }
        }
    }
}

struct RoleSelectView_Previews: PreviewProvider {
    static var previews: some View {
        RoleSelectView()
    }
}
