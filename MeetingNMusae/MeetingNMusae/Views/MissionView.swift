import SwiftUI

// 임시 -> UserDefault로
let roomCode = "BHWK43"
let nickname = "Nick"

struct MissionView: View {
    // 진행뷰에 넘길 데이터: 참여자별 역할, 닉네임, 미션 달성도
    // 진행뷰에 넘길 데이터: 프로그레스 바 두께 (혹은 전역변수에서 가져옴)
    
    // 미션 수행 정도
    @ObservedObject var userViewModel = UserViewModel()
    // 미션 정보
    var missionViewModel = MissionViewModel()

    // 진행자가 회의 종료를 선택하면 참가자도 자동으로 다음 뷰로 넘어가기 위해 필요
    @ObservedObject var meetingRoomViewModel = MeetingRoomViewModel()

    @State var didMissions: [Bool] = [false, false, false]
    
    
    // 임시
    @State var isEnded: Bool = false
//    @State var prog: [Double] = [0.0, 1.0, 0.6, 0.3, 0.3, 0.6]
//    let roleName = "금고무새"
//    @State var didMissions: [Bool] = [true, false, false]
    // 진행자인지
//    let isFacilitator = true

    // 폰트 크기에 따라 수정 예정
    let textheight = UIScreen.screenHeight * 0.06

    var body: some View {
        
        if isEnded {
//        if $meetingRoomViewModel.isEnded {
            // 임시
            Text("회의 종료 임시 뷰")
            //MeetingEndView()
        } else {
            VStack {
                // 다른 사람 역할 미션 프로필 보기
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(userViewModel.users) { user in
                            // 넘길 데이터: 참여자별 역할, 닉네임, 미션 달성도
                            // MARK: 넘길 데이터: 화면비 해당 프로그레스 바 두께
                            // 내 역할 제외하기
                            if user.nickname != nickname {
                                // linewidth 는 화면에 따른 변경 반영해야할 듯
                                MissionProgressCircleView(user: user, lineWidth: 5)
                                
                                // ??
                                // MissionProgressCircleView(roleId: user.roleId, username: user.nickname, progress: user.getMissionProgress(), lineWidth: 5)
                            }
                        }
                    }
                    // 이게 맞나..?
                    .onAppear{
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
                let myRoleId: Int = userViewModel.getUser(nickname).roleId
//                // state 쓰는 게 맞나..? 바인딩은 돼야하는데
//                didMissions = userViewModel.getUser(nickname).missionProgress
                
                
                missionCardView(
                    roleId: myRoleId, didMissions: userViewModel.getUser(nickname).missionProgress, missions: missionViewModel.getMissionsStr(roleId: myRoleId)
                )
                .onAppear{
                    missionViewModel.fetchData(roleId: myRoleId)
                }
                .padding()

                Spacer()
                
                // 진행자 회의 종료 버튼
                // 진행자가 회의 종료시 참가자 넘어갈 방법?
                  // 일단 If로 돌릴 생각인데
                  // 아니면 파이어베이스 미팅룸에서 뷰 단계 저장해도 될 듯ㅋ
                
                if userViewModel.getUser(nickname).roleId == 0 {
                    Button(action: {
                        // 파이어베이스에 회의종료 set하기
                        
                    }){
                        Text("회의 종료하기")
                            // 폰트 추후 수정
                            .foregroundColor(.pink)
                    }
                    // 필요한가..?
                    .onAppear{
                        userViewModel.fetchData(roomCode: roomCode)
                    }
                }
            }
        }
    }
}

@ViewBuilder
func missionCardView(roleId: Int, didMissions: [Bool], missions: [String]) -> some View {
//func missionCardView(roleId: Int, didMissions: Binding<[Bool]>, missions: [String]) -> some View {
    // 서버에서 받을 데이터: 현재 역할, 미션, 미션 수행 했는지
    // 서버에 보낼 데이터: 미션 수행 했는지
    
    // roleId가 0 이상인지, 1에서 시작할 것인지.. 파이어스토어에 0 있음
    let roleId = roleId
    let roleName = Role.roles[roleId].roleName
    let imageName = roleName
//    let missions = ["미션1", "미션2", "미션3"]

    VStack {
        // 추후 이미지 크기 조정 필요
        Image(imageName)
            .resizable()
            .scaledToFit()
        Text(roleName)

        // 코지의 라인 익스텐션 사용
        Line().stroke(style: StrokeStyle(lineWidth: 3, dash: [10]))
            .frame(height: 1)

        HStack {
            Text("**미션**") // add font
            Spacer()
        }
        .padding()
        ForEach(0...2, id: \.self) { mission in
            HStack {
                CheckBoxView(checked: didMissions[mission], roleId: roleId)
                Text(missions[mission])
                // 폰트 추가
                Spacer()
            }
                .padding()
        }
    }
    .padding()
    .padding(.bottom)
    .background(
        // 임시 CharacterBox에서 height, width 자동 설정으로 수정
        CharacterBox(roleIndex: roleId)
    )
}

// ref: https://stackoverflow.com/questions/58425829/how-can-i-create-a-text-with-checkbox-in-swiftui
struct CheckBoxView: View {
//    @Binding var checked: Bool
    var checked: Bool
    let roleId: Int
    @ObservedObject var missionViewModel = MissionViewModel()

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(
                checked ? Color(UIColor.black) : Color.secondary)
            .onTapGesture {
//                checked.toggle()
                // MARK: 파이어베이스 update 하기
                missionViewModel.fetchData(roleId: roleId)
                missionViewModel.updateMissionProgress(roomCode: roomCode, nickname: nickname)
            }
    }
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
        MissionView()
            .previewInterfaceOrientation(.portrait)
    }
}
