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
    @State var owner: String = ""
    @State var roles: [Role] = Role.roles
    @ObservedObject var meetingRoomViewModel = MeetingRoomViewModel()

    private var db = Firestore.firestore()

    var body: some View {
        VStack(alignment: .center) {
            Text("역할을 골라주세요").font(.title2).bold()
            
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
                                RoleItem(role: roles[i], roleSelectUser: meetingRoom.roleSelectUsers[i], roomCode: roomCode, nickname: nickname)
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
                            meetingRoomViewModel.completedRoleSelect(roomCode: roomCode)
                        }, label: {
                            // nick의 SelectBox가 나오면 주석 해제
//                            SelectBox(isDark: true, description: "선택 완료")
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
        }
    }
}

struct RoleItem: View {
    @State var isModalShown = false
    @State var role: Role
    @State var roleSelectUser: String
    var roomCode: String
    @State var nickname: String

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
                        .padding(.bottom)
                        .foregroundColor(.black)
                        .opacity(roleSelectUser == "" ? 1 : 0.5)
                }

                VStack {
                    HStack {
                        if roleSelectUser == "" {
                            if role.id <= 3 {
                                Image(systemName: "star.circle.fill")
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
                RoleDetailView(role: role, isModalShown: $isModalShown)
                    .ignoresSafeArea()
            }.navigationBarHidden(true)
        }
    }
}
