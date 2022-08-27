//
//  RoleSelectView.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/09.
//

import SwiftUI
import FirebaseFirestore

let characterSize: CGFloat = UIScreen.screenWidth / 4

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

    var body: some View {
        VStack(alignment: .center) {
            Text("역할을 골라주세요").font(.title2).bold()
                .padding(EdgeInsets(top: 28, leading: 0, bottom: 3, trailing: 0))
            
            HStack {
                Image(systemName: "star.circle.fill")
                Text("필수 역할입니다")
            }
            .font(.subheadline)
            .foregroundColor(Color.gray)
            
            ForEach(meetingRoomViewModel.meetingRooms) { meetingRoom in
                VStack {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(0..<roles.count, id: \.self) { i in
                                RoleItem(role: roles[i], roleSelectUser: meetingRoom.roleSelectUsers[i], roomCode: roomCode, meetingRoomViewModel: meetingRoomViewModel)
                                    .background(meetingRoom.roleSelectUsers[i] != "" ? CharacterBox(roleIndex: 0) : CharacterBox(roleIndex: roles[i].id))
                                    .padding(.leading)
                                    .padding(.bottom)
                            }
                        }
                        .padding(.top)
                        .padding(.trailing)
                    }
                    .padding(.trailing, 8)

                    if meetingRoom.owner == nickname {
                        Button(action: {
                            // todo
                            // 유니스 화면으로 이동
                            // 회의 전체에 시작함 이라는 변수 넣기
                            // reviews의 reviewee_role_id 에 랜덤 값으로 중복 없이 넣어주기
                            if  meetingRoomViewModel.meetingRooms[0].roleSelectUsers.filter({ $0.count > 0 }).count == userViewModel.users.count {
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
                            SelectBox(isDark: true, description: meetingRoomViewModel.meetingRooms[0].roleSelectUsers.filter { $0.count > 0 }.count == userViewModel.users.count ? "선택 완료" : "선택 중...")
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
    @ObservedObject var meetingRoomViewModel: MeetingRoomViewModel

    var body: some View {
        Button {
            isModalShown = true
        } label: {
            ZStack {
                VStack {
                    Image("\(role.roleName)")
                        .resizable()
                        .scaledToFill()
                        .frame(height: characterSize)
                        .opacity(roleSelectUser == "" ? 1 : 0.5)
                        .padding(.top)
                    Text("\(role.roleName)")
                        .bold()
                        .padding(.bottom)
                        .foregroundColor(.black)
                        .opacity(roleSelectUser == "" ? 1 : 0.5)
                }

                VStack {
                    HStack {
                        if roleSelectUser == "" {
                            if role.id <= 3 {
                                Image(systemName: "star.circle.fill")
                                    .font(.system(size: 20))
                            }
                        } else {
                            Text("\(roleSelectUser)")
                                .bold()
                                .padding(4)
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 6.0).fill(Color.black))
                        }
                        
                        Spacer()
                    }
                    .foregroundColor(Color.black)
                    .padding(10)
                    
                    Spacer()
                }
            }
        }.sheet(isPresented: $isModalShown) {
            NavigationView {
                RoleDetailView(role: role, isModalShown: $isModalShown, meetingRoomViewModel: meetingRoomViewModel)
                    .ignoresSafeArea()
            }.navigationBarHidden(true)
        }
    }
}
