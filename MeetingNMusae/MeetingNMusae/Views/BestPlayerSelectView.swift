//
//  BestPlayerSelectView.swift
//  MeetingNMusae
//
//  Created by JiwKang on 2022/06/17.
//

import SwiftUI
import FirebaseFirestore

struct BestPlayerSelectView: View {
    @State var columns: [GridItem] = [
        GridItem(),
        GridItem()
    ]
    @State var remainTime: Int = 10
    @State var roles: [Role] = Role.roles
    @State var nickname = ""
    @State var roomCode = UserDefaults.standard.string(forKey: "roomCode") ?? ""
    @ObservedObject var userViewModel = UserViewModel()
    private let leadPadding = UIScreen.screenWidth * 0.03
    private let trailingPadding = UIScreen.screenWidth * 0.0923
    private let generalPadding = UIScreen.screenWidth * 0.0718
    private var db = Firestore.firestore()
    private var characterSize = UIScreen.screenHeight * 0.1422

    var body: some View {
        VStack(alignment: .center) {
            Text("최고의 무새를 골라주세요")
                .font(.title2)
                .bold()
                .padding(.vertical)

            Text("\(remainTime)")
                .font(.title2)
                .bold()
                .padding(6)
                .padding(.horizontal, 6)
                .background(RoundedRectangle(cornerRadius: 36).fill(Color(hex: "#EFEFEF")))
                .task(timer)
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(userViewModel.users) { user in
                        if user.roleId == 0 {
                            EmptyView()
                        } else {
                            Button(action: {
                                nickname = user.nickname
                            }, label: {
                                PlayerItem(role: roles[user.roleId - 1], user: user, nickname: $nickname)
                                    .background(CharacterBox(roleIndex: nickname == user.nickname ? 0 : user.roleId))
                            }).padding(.leading, leadPadding)
                                .padding(.bottom, generalPadding)
                        }
                    }
                }
                .padding(.top, UIScreen.screenHeight * 0.038)
                .padding(.trailing, trailingPadding)
            }
            .padding(.leading, UIScreen.screenWidth * 0.04)
        }
        .navigationBarHidden(true)
        .onAppear {
            self.userViewModel.fetchData(roomCode: roomCode)
        }.onDisappear {
            if nickname != "" {
                self.userViewModel.voteUser(roomCode: roomCode, nickname: nickname)
            }
        }
    }
    
    @Sendable private func timer() async {
        while remainTime > 0 {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            remainTime -= 1
        }
        MeetingRoomViewModel().bestRoleSelected(roomCode: roomCode)
    }
}

struct PlayerItem: View {
    @State var role: Role
    @State var user: User
    @Binding var nickname: String
    @State var roomCode = UserDefaults.standard.string(forKey: "roomCode") ?? ""
    
    @ObservedObject var userViewModel = UserViewModel()
    private let characterSize: CGFloat = UIScreen.screenWidth / 4

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Image("\(role.roleName)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: characterSize)
                    .padding(.top, 8)
                Spacer()
            }

            VStack {
                HStack {
                    Text("\(user.nickname)")
                        .bold()
                        .padding(4)
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 6.0).fill(Color.black))
                    
                    Spacer()
                }
                .foregroundColor(Color.black)
                .padding(10)
                
                Spacer()
                Text("\(role.roleName)")
                    .bold()
                    .padding(.bottom, 16)
                    .foregroundColor(.black)
            }
        }
        .opacity(nickname == user.nickname ? 0.5: 1)
        .frame(width: UIScreen.screenWidth * 0.39, height: UIScreen.screenWidth * 0.41)

    }
}
