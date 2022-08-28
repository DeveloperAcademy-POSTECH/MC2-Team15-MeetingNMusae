//
//  BestPlayerShowingView.swift
//  MeetingNMusae
//
//  Created by Heeji Sohn on 2022/06/14.
//

import SwiftUI
import FirebaseFirestore

struct BestPlayerShowingView: View {
    @State var roomCode: String
    @State var roles: [Role] = Role.roles
    @ObservedObject var meetingRoomViewModel = MeetingRoomViewModel()
    @ObservedObject var userViewModel = UserViewModel()
    
    @State var remainTime: Int = 4
    
    private var db = Firestore.firestore()
    
    init(roomCode: String) {
        self.roomCode = roomCode
    }
    var body: some View {
        ZStack {
            VStack {
                Image("celebratemusae")
                    .frame(width: 344, height: 219)
                    .padding(.top, 68)
                    .padding(.bottom, 33)
                if userViewModel.user.nickname != "" {
                    ZStack {
                        VStack(spacing: 0) {
                            HStack {
                                NameBox(user: userViewModel.user.nickname)
                                Spacer()
                            }
                            .foregroundColor(Color.black)
                            .padding(12)

                            Spacer()
                            Text("\(roles[userViewModel.user.roleId - 1].roleName)")
                                .fontWeight(.bold)
                                .padding(.bottom, 16)
                                .foregroundColor(.black)
                        }
                        VStack(spacing: 0) {
                            Image("\(roles[userViewModel.user.roleId - 1].roleName)")
                                .padding(.top, 8)
                            Spacer()

                        }
                    }
                    .frame(width: 153, height: 160)
                    .background(CharacterBox(roleIndex: userViewModel.user.roleId))
                } else {
                    ZStack {
                        VStack(spacing: 0) {
                            HStack {
                                NameBox(user: "모두")
                                Spacer()
                            }
                            .foregroundColor(Color.black)
                            .padding(12)

                            Spacer()
                            Text("회의하는N무새")
                                .fontWeight(.bold)
                                .padding(.bottom, 16)
                                .foregroundColor(.black)
                        }
                        VStack(spacing: 0) {
                            Image("회의하는N무새")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120)
                                .padding(.top, 8)
                            Spacer()

                        }
                    }
                    .frame(width: 153, height: 160)
                    .background(CharacterBox(roleIndex: 0))
                }
                Spacer()
            }
            LottieView(name: "confetti", loopMode: .loop)
                .scaledToFill()
                .ignoresSafeArea(edges: .top)
        }
        .onAppear {
            self.userViewModel.getBestPlayer(roomCode: roomCode)
        }
        .task(timer)
    }
    
    func timer() async {
        while remainTime > 0 {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            remainTime -= 1
        }
        MeetingRoomViewModel().reviewStart(roomCode: roomCode)
    }
}
