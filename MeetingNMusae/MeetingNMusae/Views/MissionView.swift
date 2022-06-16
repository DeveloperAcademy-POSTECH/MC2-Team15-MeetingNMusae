import SwiftUI

// 임시 -> UserDefault로
let roomCode = "ROOMCODE1"
let nickname = "Nick1"

struct MissionView: View {
    // 진행뷰에 넘길 데이터: 참여자별 역할, 닉네임, 미션 달성도
    // 진행뷰에 넘길 데이터: 프로그레스 바 두께 (혹은 전역변수에서 가져옴)
    
    // 미션 수행 정도
    @ObservedObject var userViewModel = UserViewModel()
    // 진행자가 회의 종료를 선택하면 참가자도 자동으로 다음 뷰로 넘어가기 위해 필요
    @ObservedObject var meetingRoomViewModel = MeetingRoomViewModel()

    @State var didMissions: [Bool] = [false, false, false]

    // 임시
    @State var isEnded: Bool = false
    // 이거 어쩌지
    let myRoleId = 0 // 되..나?

    // 폰트 크기에 따라 수정 예정
    let textheight = UIScreen.screenHeight * 0.06
    
    var body: some View {
        
        
        if isEnded {
//        if meetingRoomViewModel.isEnded {
            // 임시
            Text("회의 종료 임시 뷰")
            // MeetingEndView()
        } else {
            VStack {
                // 다른 사람 역할 미션 프로필 보기
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(userViewModel.users) { user in
                            // 넘길 데이터: 참여자별 역할, 닉네임, 미션 달성도
                            // MARK: 넘길 데이터: 화면비 해당 프로그레스 바 두께
                            // 내 역할 제외하기
                              // 는 테스트용으로 잠시 disable
//                            if user.nickname != nickname { // for testing
                                // linewidth 는 화면에 따른 변경 반영해야할 듯
                                MissionProgressCircleView(user: user, lineWidth: 5)
                                .onAppear {
                                    print("MPCV onAppear")
                                }
//                            } // for testing
                        }
                    }
                    .onAppear {
                        print("onAppear uVM.fetchData")
                        userViewModel.fetchData(roomCode: roomCode)
                    }
                    // 코지의 UIScreen+Extensions에 맞춤
                    .frame(height: UIScreen.screenWidth*0.2+textheight)
                    .padding()
                }

                // 내 역할 미션 카드
                
                // 넘길 데이터: 현재 역할
                // 넘길 데이터: 현재 역할의 미션과 진행도
                
                // 이게 되려나..?.
                // 이쪽 때문에 뷰 conform 안 되는 중
//                let myRoleId: Int = userViewModel.getUser(nickname)?.roleId ?? 0
//                // state 쓰는 게 맞나..? 바인딩은 돼야하는데
//                didMissions = userViewModel.getUser(nickname).missionProgress
                
                // 이거 아님
                MissionCardView(roleId: myRoleId, didMissions: [false,false,false])
                .padding()

                Spacer()
                
                // 진행자 회의 종료 버튼
                // 진행자가 회의 종료시 참가자 넘어갈 방법?
                  // 일단 If로 돌릴 생각인데
                  // 아니면 파이어베이스 미팅룸에서 뷰 단계 저장해도 될 듯ㅋ
                
                if userViewModel.getUser(nickname)?.roleId == 0 {
                    Button {
                        // 파이어베이스에 회의종료 set하기
                        
                    } label: {
                        Text("회의 종료하기")
                            // 폰트 추후 수정
                            .foregroundColor(.pink)
                    }
                    // 필요한가..?
                    .onAppear {
                        userViewModel.fetchData(roomCode: roomCode)
                    }
                }
            }
        }
    }
}

//struct MissionView_Previews: PreviewProvider {
//    static var previews: some View {
//        MissionView()
//            .previewInterfaceOrientation(.portrait)
//    }
//}
