//
//  BestPlayerShowingView.swift
//  MeetingNMusae
//
//  Created by Heeji Sohn on 2022/06/14.
//

import SwiftUI
import FirebaseFirestore


//let roomCode = "WP3LX4"
//let nickname = "Sohni"


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
                    .frame(width:344,height:219)
                    .padding(.top,68)
                    .padding(.bottom,33)
                VStack {
                    BestPlayerCheck(role: roles[userViewModel.user.roleId], nickname: userViewModel.user.nickname)
                        .background(CharacterBox(roleIndex: userViewModel.user.roleId))
                    //           Text("\(userViewModel.user.nickname)")
                    //            Text("\(userViewModel.user.roleId)")
                    
                }
                Spacer()
            }
            
            LottieView(name: "confetti", loopMode: .loop)
                .scaledToFill()
                .ignoresSafeArea(edges:.top)
        }
        .onAppear() {
            self.userViewModel.getMaxVotedCount(roomCode: roomCode)
        }
    }
}


struct BestPlayerCheck: View {
    @State var role: Role
    @State var nickname: String
    
    var body: some View {
        ZStack {
            VStack {
                
                Image("\(role.roleName)")
                    .resizable()
                    .scaledToFill()
                    .frame(width:120, height: 120)
                
                Text("\(role.roleName)")
                    .fontWeight(.bold)
                    .padding(.bottom)
                    .foregroundColor(.black)
                

            }
            .frame(width:153,height: 160)
        }
        
    }
}


//struct BestPlayerShowingView_Previews: PreviewProvider {
//    static var previews: some View {
//        BestPlayerShowingView(roomCode: <#T##String#>, nickname: <#T##String#>)
//    }
//}
