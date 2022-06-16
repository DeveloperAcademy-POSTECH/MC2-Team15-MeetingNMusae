//
//  BestPlayerShowingView.swift
//  MeetingNMusae
//
//  Created by Heeji Sohn on 2022/06/14.
//

import SwiftUI
import FirebaseFirestore

// 임시
let roomCode = "W1LT3H"
let nickname = "Sohni"


struct BestPlayerShowingView: View {
    
    @State var columns: [GridItem] = [
        GridItem(),
        GridItem()
    ]
    
    
    @State var roomCode: String
    @State var roles: [Role] = Role.roles
    @State var user: User
    //  @State var roleSelectUsers: String
    @ObservedObject var meetingRoomViewModel = MeetingRoomViewModel()
    
    var votedCntArr:[Int] = [1,3,2,5,1,7,2,3]
    
    private var db = Firestore.firestore()
    
    init(roomCode: String, nickname: String) {
        self.roomCode = roomCode
        self.user = User(missionIds: [0, 1, 2], nickname: nickname, roomCode: roomCode)
    }
    
    let imageName = "금고무새"
    var body: some View {
        
        
        
        ZStack {
            
            VStack {
                //                Text("최고의 플레이어!")
                //                    .font(.system(size:24))
                //                    .fontWeight(.bold)
                //                    .padding(.bottom, 92)
                //                    .padding(.top, 30)
                
                Image("celebratemusae")
                    .frame(width:344,height:219)
                    .padding(.top,68)
                    .padding(.bottom,33)
                
                VStack {
                    
                    
                    if let (maxIndex, maxValue) = votedCntArr.enumerated().max(by: { $0.element < $1.element }) {
                        Text("max is \(maxValue) at index \(maxIndex)")
                    }
                    
                    
                    
                }
                
                //                    Image(imageName)
                //                        .resizable()
                //                        .scaledToFit()
                //                        .frame(width:155,height:155)
                
                HStack {
                    BestPlayerCheck(role: roles[1],   roomCode: roomCode, nickname: user.nickname)
                        .padding(.leading)
                        .padding(.bottom)
                }
                .background(CharacterBox(roleIndex: roles[1].id)) //임시
            
            
            
            Spacer()
            
            //                ScrollView {
            //
            //                    ForEach(meetingRoomViewModel.meetingRooms) { meetingRoom in
            //                        ForEach(0..<roles.count, id: \.self) { i in
            //                            BestPlayerCheck(role: roles[i], roleSelectUser: meetingRoom.roleSelectUsers[i], roomCode: roomCode, nickname: user.nickname)
            //                                .padding(.leading)
            //                                .padding(.bottom)
            //
            //                        }
            //                    }
            //                    .onAppear {
            //                        self.meetingRoomViewModel.fetchData(roomCode: roomCode)
            //                    }
            //                    //     .padding(.top)
            //                    //      .padding(.trailing)
            //                }
            
        }
        
        LottieView(name: "confetti", loopMode: .loop)
            .scaledToFill()
            .ignoresSafeArea(edges:.top)
        
    }
    
}
}


///fb 데이터 불러오는거까지 성공 MAX(count) 하면됨
struct BestPlayerCheck: View {
    @State var isModalShown = false
    @State var role: Role
    //   @State var roleSelectUser: String
    var roomCode: String
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
                
            }
            
            //            VStack {
            //                HStack {
            //                    Text("\(roleSelectUser)")
            //                        .bold()
            //                        .padding(4)
            //                        .foregroundColor(.white)
            //                        .background(RoundedRectangle(cornerRadius: 6.0).fill(Color.black))
            //                }
            //                .foregroundColor(Color.black)
            //                .padding(10)
            //                Spacer()
            //            }
            
        }
        
    }
}





struct BestPlayerShowingView_Previews: PreviewProvider {
    static var previews: some View {
        BestPlayerShowingView(roomCode:roomCode, nickname:nickname)
    }
}
