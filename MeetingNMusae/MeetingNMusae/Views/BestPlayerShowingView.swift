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
                ZStack {
                    VStack {
                        HStack {
                            Text("\(userViewModel.user.nickname)")
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
                    VStack {
                        Image("\(roles[userViewModel.user.roleId].roleName)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                        
                        Text("\(roles[userViewModel.user.roleId].roleName)")
                            .fontWeight(.bold)
                            .padding(.bottom)
                            .foregroundColor(.black)
                    }
                }
                .frame(width: 153, height: 160)
                .background(CharacterBox(roleIndex: userViewModel.user.roleId))
                Spacer()
            }
            
            LottieView(name: "confetti", loopMode: .loop)
                .scaledToFill()
                .ignoresSafeArea(edges: .top)
        }
        .onAppear {
            self.userViewModel.getBestPlayer(roomCode: roomCode)
        }
    }
}
