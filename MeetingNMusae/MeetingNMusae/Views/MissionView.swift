import SwiftUI

// 역할 카드
struct MissionView: View {

    // 미션 수행 정도
    @ObservedObject var userViewModel = UserViewModel()
    // 진행자가 회의 종료를 선택하면 참가자도 자동으로 다음 뷰로 넘어가기 위해 필요
    @ObservedObject var meetingRoomViewModel = MeetingRoomViewModel()
    
    // 임시
    @ObservedObject var missionViewModel = MissionViewModel()

    let roomCode = UserDefaults.standard.string(forKey: "roomCode") ?? ""
    let nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
    let roleId = UserDefaults.standard.integer(forKey: "roleId")
    
    // 폰트 크기에 따라 수정 예정
    let textheight: CGFloat = 34 // UIScreen.screenHeight * 0.06
    
    var body: some View {
        if meetingRoomViewModel.isEnded {
//        if meetingRoomViewModel.isEnded {
            // 임시
            Text("회의 종료 임시 뷰")
            // MeetingEndView()
        } else {
            VStack {
                // 다른 사람 역할 미션 프로필 보기
                ScrollView(.horizontal) {
                    HStack {
                        // MARK: 역할 순서에 맞게 변경 필요
                        // users에서 정렬..?
                        ForEach(userViewModel.users) { user in
                            // 넘길 데이터: 참여자별 역할, 닉네임, 미션 달성도
                            // MARK: 넘길 데이터: 화면비에 해당하는 프로그레스 바 두께
                            // 내 역할 제외하기
                            if user.nickname != nickname {
                                MissionProgressCircleView(user: user, lineWidth: 4)
                                .padding(.trailing, 5)
                                .onAppear {
                                    print("MPCV onAppear")
                                }
                            }
                        }
                    }
                    // 코지의 UIScreen+Extensions에 맞춤
                    .frame(height: UIScreen.screenWidth*0.2+textheight)
                    .padding(.leading, 28)
                    .padding(.top, 58)
                    .padding(.bottom, 24)
//                }.onAppear {
//                    self.userViewModel.fetchData(roomCode: roomCode, nickname: nickname, sort: true)
                }

                // 내 역할 미션 카드
                MissionCardView(userViewModel: userViewModel, missionViewModel: missionViewModel)
                    .frame(height: 510)
                    .padding(.horizontal, 28)
                    //.padding(.bottom, 2)

                // 진행자 회의 종료 버튼
                if roleId == 1 {
                    Button {
                        // 파이어베이스에 회의종료 set하기
                        meetingRoomViewModel.updateIsEnded(roomCode: roomCode)
                    } label: {
                        Text("회의 종료하기")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.buttonGray)
                            .padding(54)
                    }
                } else {
                    Text("진행자 아님. roleId: \(roleId)")
//                        .onTapGesture {
//                            meetingRoomViewModel.updateIsEnded(roomCode: roomCode)
//                        }
                        .font(.system(size: 18, weight: .bold))
//                        .foregroundColor(.white)
                        .padding(54)
                }
                Spacer()// .frame(height: 2)
            }
            .onAppear {
                self.userViewModel.fetchData(roomCode: roomCode, nickname: nickname, sort: true)
                self.missionViewModel.fetchMissions(roleId: roleId)
            }
        }
        
    }
}

// struct MissionView_Previews: PreviewProvider {
//    static var previews: some View {
//        MissionView()
//            .previewInterfaceOrientation(.portrait)
//    }
// }
