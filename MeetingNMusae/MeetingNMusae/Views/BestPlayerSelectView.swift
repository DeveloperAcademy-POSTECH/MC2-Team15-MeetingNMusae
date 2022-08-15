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
    
    @State var remainTime: Int = 1
    
    @State var roles: [Role] = Role.roles
    @State var nickname = ""
    @State var roomCode = UserDefaults.standard.string(forKey: "roomCode") ?? ""
    @ObservedObject var userViewModel = UserViewModel()
    
    private var db = Firestore.firestore()
    
    var body: some View {
        VStack(alignment: .center) {
            Text("최고의 무새를 골라주세요")
                .font(.title2)
                .bold()
                .padding(.bottom)
                .padding(.top)
            
            Text("\(remainTime)")
                .font(.title2)
                .bold()
                .padding(6)
                .padding(.trailing, 6)
                .padding(.leading, 6)
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
                            }).padding(.leading)
                                .padding(.bottom)
                        }
                    }
                }
                .padding(.top)
                .padding(.trailing)
            }
            .padding(.trailing, 8)
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
    
    func timer() async {
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
    
    var body: some View {
        ZStack {
            VStack {
                Image("\(role.roleName)")
                    .resizable()
                    .scaledToFill()
                    .frame(height: characterSize)
                    .padding(.top)
                Text("\(role.roleName)")
                    .bold()
                    .padding(.bottom)
                    .foregroundColor(.black)
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
            }
        }
        .opacity(nickname == user.nickname ? 0.5: 1)
    }
}
