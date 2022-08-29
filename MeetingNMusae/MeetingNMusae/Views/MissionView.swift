import SwiftUI

// 역할 카드
struct MissionView: View {
    // 미션 수행 정도
    @ObservedObject var userViewModel = UserViewModel()
    // 진행자가 회의 종료를 선택하면 참가자도 자동으로 다음 뷰로 넘어가기 위해 필요
    @ObservedObject var meetingRoomViewModel = MeetingRoomViewModel()
    // 이 뷰에서 미션 내용을 가져오고, 미션카드뷰에서 미션 내용을 읽어오기 위해 필요.
    // 없이 하면 미션카드뷰에서 미션 내용이 로딩 안 됨.
    @ObservedObject var missionViewModel = MissionViewModel()

    #if DEBUG
    let roomCode = /*"D4M3KK"*/ UserDefaults.standard.string(forKey: "roomCode") ?? ""
    let nickname = /*"EUNI"*/ UserDefaults.standard.string(forKey: "nickname") ?? ""
    let roleId = /*1*/ UserDefaults.standard.integer(forKey: "roleId")
    #else
    let roomCode = UserDefaults.standard.string(forKey: "roomCode") ?? ""
    let nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
    let roleId = UserDefaults.standard.integer(forKey: "roleId")
    #endif

    // 폰트 크기에 따라 수정 예정
    let textheight: CGFloat = 34 // UIScreen.screenHeight * 0.06
    private let leadingPadding = UIScreen.screenWidth * 0.0718
    private let trailingPadding = UIScreen.screenWidth * 0.0923

    var body: some View {
        VStack {
            Spacer()
            // 다른 사람 역할 미션 프로필 보기
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    // MARK: 역할 순서에 맞게 변경 필요
                    ForEach(userViewModel.users) { user in
                        // 넘길 데이터: 참여자별 역할, 닉네임, 미션 달성도
                        // MARK: 넘길 데이터: 화면비에 해당하는 프로그레스 바 두께
                        // 내 역할 제외하기
                        if user.nickname != nickname {
                            MissionProgressCircleView(user: user, lineWidth: 4)
                            .padding(.trailing, 5)
                        }
                    }
                }
                // 코지의 UIScreen+Extensions에 맞춤
                .frame(height: UIScreen.screenWidth*0.2+textheight)
                .padding(.leading, 28)
            }
            Spacer()
            // 내 역할 미션 카드
            MissionCardView(userViewModel: userViewModel, missionViewModel: missionViewModel)
                .frame(idealHeight: 510, maxHeight: 510)
                .padding(.leading, leadingPadding)
                .padding(.trailing, trailingPadding)
                .padding(.bottom)

            Spacer()
            Spacer()
            // 진행자 회의 종료 버튼
            if roleId == 1 {
                Button {
                    // 파이어베이스에 회의종료 set하기
                    meetingRoomViewModel.endMeeting(roomCode: roomCode)
                } label: {
                    Text("회의 종료하기")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(.buttonGray)
                }
            } else {
                EmptyView()
            }
            Spacer()
        }
        .onAppear {
            self.userViewModel.fetchData(roomCode: roomCode, nickname: nickname, sort: true)
            self.missionViewModel.fetchMissions(roleId: roleId)
        }
    }
}
