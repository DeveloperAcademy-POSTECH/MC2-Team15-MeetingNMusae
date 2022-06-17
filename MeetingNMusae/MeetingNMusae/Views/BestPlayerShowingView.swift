//
//  BestPlayerShowingView.swift
//  MeetingNMusae
//
//  Created by Heeji Sohn on 2022/06/14.
//

import SwiftUI
import FirebaseFirestore

// 임시
//let roomCode = "WP3LX4"
//let nickname = "Sohni"


struct BestPlayerShowingView: View {
    @State var roomCode: String
    @State var roles: [Role] = Role.roles
    @ObservedObject var meetingRoomViewModel = MeetingRoomViewModel()
    @ObservedObject var userViewModel = UserViewModel()
    
    
    var votedCntArr:[Int] = [1,3,2,5,1,7,2,3]
    
    private var db = Firestore.firestore()
    
    init(roomCode: String) {
        self.roomCode = roomCode
    }
    
    let imageName = "금고무새"
    var body: some View {
        ZStack {
            LottieView(name: "confetti", loopMode: .loop)
                .scaledToFill()
                .ignoresSafeArea(edges:.top)
            VStack {
                
                
                Image("celebratemusae")
                    .frame(width:344,height:219)
                    .padding(.top,68)
                    .padding(.bottom,33)
                VStack {
                    
                    Text("\(userViewModel.user.nickname)")
                    Text("\(userViewModel.user.roleId)")
                    
                    if let (maxIndex, maxValue) = votedCntArr.enumerated().max(by: { $0.element < $1.element }) {
                        Text("max is \(maxValue) at index \(maxIndex)")
                    }
                }
                Button(action: {
                    self.userViewModel.getMaxVotedCount(roomCode: roomCode)
                }, label: {
                    Text("가져오기")
                })
                Spacer()
            }
            
            
        }
        .onAppear() {
            self.userViewModel.getMaxVotedCount(roomCode: roomCode)
        }
    }
}


///fb 데이터 불러오는거까지 성공 MAX(count) 하면됨
struct BestPlayerCheck: View {
    @State var role: Role
    //   @State var roleSelectUser: String
    @State var nickname: String
    
    var body: some View {
        ZStack {
            VStack {
                
                Image("\(role.roleName)")
                    .resizable()
                    .scaledToFit()
                    .padding(.top)
                    .frame(height:characterSize)
                Text("\(role.roleName)")
                    .padding(.bottom)
                    .foregroundColor(.black)
                Text("\(nickname)")
                    .padding(.bottom)
                    .foregroundColor(.black)
            }
        }
        
    }
}





//struct BestPlayerShowingView_Previews: PreviewProvider {
//    static var previews: some View {
//        BestPlayerShowingView(roomCode: <#T##String#>, nickname: <#T##String#>)
//    }
//}
