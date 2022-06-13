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
        VStack(alignment: .center) {
            ZStack {
                HStack {
                    Button(action: {
                        // todo
                        // 방 선택뷰로 이동하는 기능
                    }, label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right").rotationEffect(.degrees(180))
                    })
                    .foregroundColor(.black)
                    .padding(.leading)
                    
                    Spacer()
                }
                
                Text("역할을 골라주세요").font(.title2).bold()
            }.padding(.top)
            
            HStack {
                Image(systemName: "star.circle.fill")
                Text("필수 역할입니다")
            }
            .font(.subheadline)
            .foregroundColor(Color.gray)

            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(meetingRoomViewModel.meetingRooms) { meetingRoom in
                        ForEach(0..<roles.count, id: \.self) { i in
                            RoleItem(role: roles[i], roleSelectUser: meetingRoom.roleSelectUsers[i], roomCode: roomCode, nickname: user.nickname)
                                .background(meetingRoom.roleSelectUsers[i] != "" ? CharacterBox(roleIndex: 0) : CharacterBox(roleIndex: roles[i].id))
                                .padding(.leading)
                                .padding(.bottom)
                        }
                    }
                }.onAppear {
                    self.meetingRoomViewModel.fetchData(roomCode: roomCode)
                }
                .padding(.top)
                .padding(.trailing)
            }
            .padding(.trailing, 8)
        }
        .navigationBarHidden(true)
//        .navigationTitle("역할을 골라주세요")
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: {
//                    // todo
//                    // 방 선택뷰로 이동하는 기능
//                }, label: {
//                    Image(systemName: "rectangle.portrait.and.arrow.right").rotationEffect(.degrees(180))
//                })
//                .foregroundColor(.black)
//            }
//        }
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
                RoleDetailView(role: role, roomCode: roomCode, nickname: nickname, isModalShown: $isModalShown)
            }
        }
    }
}
